\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{p-oldpaper}[2013/08/28 Old Paper Like Poster]
\LoadClass{article}
\pagestyle{empty}

\RequirePackage{geometry}
\RequirePackage{calc}
\RequirePackage{ifthen}
\RequirePackage{anyfontsize}
\RequirePackage{tikz}
\RequirePackage{varwidth}
\RequirePackage{authblk}
\RequirePackage{tgpagella}
\RequirePackage[T1]{fontenc}
\RequirePackage{titlesec}

\DeclareOption{draft}{
	}
\ProcessOptions

% set author and affiliation fonts
\renewcommand\Authfont{\scshape}
\renewcommand\Affilfont{\itshape\small}

% setting up page geometry
\geometry{landscape,
				left=0.05\paperwidth,
				right=0.05\paperwidth,
				top=0.03\paperheight,
				bottom=0.03\paperheight,
				}

% ToDo: make normalsize dependant on sqrt(\paperwidth*\paperheight)
%\RequirePackage{fp}
%\FPeval{AR}{pow(\the\paperwidth,4)}
%\SQUAREROOT{\paperwidth*\paperheight}{\solution}
\newlength\AR{}
\setlength{\AR}{0.01\paperwidth}
\newlength\tAR{}
\newcommand\textmagnification[1]{
	\setlength{\tAR}{\AR*\real{#1}}
	
	\renewcommand{\tiny}{\fontsize{0.6\tAR}{0.62\tAR}\selectfont}
	\renewcommand{\scriptsize}{\fontsize{0.7\tAR}{0.72\tAR}\selectfont}
	\renewcommand{\footnotesize}{\fontsize{0.8\tAR}{0.82\tAR}\selectfont}
	\renewcommand{\small}{\fontsize{0.9\tAR}{0.92\tAR}\selectfont}
	\renewcommand{\normalsize}{\fontsize{\tAR}{1.02\tAR}\selectfont}
	\renewcommand{\large}{\fontsize{1.2\tAR}{1.22\tAR}\selectfont}
	\renewcommand{\Large}{\fontsize{1.4\tAR}{1.42\tAR}\selectfont}
	\renewcommand{\LARGE}{\fontsize{1.6\tAR}{1.62\tAR}\selectfont}
	\renewcommand{\huge}{\fontsize{1.8\tAR}{1.82\tAR}\selectfont}
	\renewcommand{\Huge}{\fontsize{2\tAR}{2.02\tAR}\selectfont}
	%\renewcommand{\HUGE}{\fontsize{2\tAR}{2.02\tAR}\selectfont}
	
	%\setlength{\parskip}{\tAR}
}
\textmagnification{1}

% set section style
\titleformat{\section}
  {\Large\scshape\raggedright}
  {}{0em}
  {}
  [\titlerule]

\setlength{\columnsep}{0.04\textwidth}
\newlength\titlefontsize{}
\setlength{\titlefontsize}{3.4\tAR}

\definecolor{umred}{rgb}{0.74901961, 0.062745098, 0.16862745}
\definecolor{umgray}{rgb}{0.25098039, 0.25098039, 0.25098039}
\definecolor{umlightgray}{rgb}{0.74901961, 0.74901961, 0.74901961}
\definecolor{title}{rgb}{0,0,0}
\definecolor{author}{rgb}{0,0,0}
\definecolor{ornament}{rgb}{0.74901961, 0.062745098, 0.16862745}

\newcommand\headerstring{}
\newcommand\header[1]{\renewcommand\headerstring{#1}}
\newcommand\footerstring{}
\newcommand\footer[1]{\renewcommand\footerstring{#1}}
\newcommand\contactstring{}
\newcommand\contact[1]{\renewcommand\contactstring{#1}}

\newcommand\overlayimg{}
\newboolean{overlayimg_isset}
\newcommand\overlay[1]{
	\renewcommand\overlayimg{#1}%
	\setboolean{overlayimg_isset}{true}
	}

\newcommand\gradientcolorA{}
\newcommand\gradientcolorB{}
\newcommand\gradientcolorAngle{}
\newboolean{gradientcolors_isset}
\newcommand\gradient[3]{
	\renewcommand\gradientcolorA{#1}%
	\renewcommand\gradientcolorB{#2}%
	\renewcommand\gradientcolorAngle{#3}%
	\setboolean{gradientcolors_isset}{true}
	}

\newcommand\affillist{\AB@affillist{}}

\newcommand*{\vcenteredhbox}[1]{\begingroup
\setbox0=\hbox{#1}\parbox{\wd0}{\box0}\endgroup}


\AtBeginDocument{
	% bg gradient
	\ifthenelse{\boolean{gradientcolors_isset}}{
		\begin{tikzpicture}[remember picture, overlay]
			\node[inner sep=0pt] at (current page.center) {
				\begin{tikzpicture}
				\shade[shading=axis,bottom color=\gradientcolorB,top color=\gradientcolorA,shading angle=\gradientcolorAngle]
				(0,0) rectangle (\paperwidth,\paperheight);
				\end{tikzpicture}
			};
		\end{tikzpicture}
	}{}

	% title section
	\noindent\begin{minipage}{\textwidth}
		\vcenteredhbox{
			\begin{tikzpicture}[scale=0.1\AR]
			\draw [ultra thick, draw=ornament, fill=ornament]
				(0,0) --(1.5,2) -- (4.5,2) -- (3,0) -- cycle;
			\end{tikzpicture}
		}
		\begin{varwidth}{.7\textwidth}
			\textbf{{\fontsize{\titlefontsize}{\titlefontsize}\selectfont\textcolor{title} \@title}}
		\end{varwidth}
		\hspace{0.01\textwidth}
		\vcenteredhbox{
			\begin{tikzpicture}[scale=0.1\AR]
			\draw [ultra thick, draw=ornament, fill=ornament]
				(0,0) --(0,2) -- (\textwidth,2) -- (\textwidth,0) -- cycle;
			\end{tikzpicture}
		}
		%
		\vspace{0.01\paperheight}
		\begin{flushright}
			\AB@authlist
		\end{flushright}
	\end{minipage}
	%
	\noindent\rule{\textwidth}{0.2\AR}
	\noindent{\scshape\contactstring}
	\hfill
	\parbox[t]{0.5\textwidth}{
		\raggedleft{\noindent\affillist}
		}
	\vfill
}

\AtEndDocument{
	\vfill
	\noindent\rule{\textwidth}{0.2\AR}
	\vspace{0.002\paperheight}
	
	% footer section
	\noindent\begin{minipage}{\textwidth}
		\footerstring
	\end{minipage}
	
	%overlay
	\begin{tikzpicture}[remember picture, overlay]
		\node[inner sep=0pt] at (current page.center) {%
			\ifthenelse{\boolean{overlayimg_isset}}{
				\includegraphics[width=\paperwidth,height=\paperheight]{\overlayimg}
			}{}
		};%
	\end{tikzpicture}
}