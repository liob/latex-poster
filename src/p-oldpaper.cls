\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{p-oldpaper}[2013/08/28 Old Paper Like Poster]
\LoadClass{article}
\pagestyle{empty}

%\RequirePackage{xcolor}
\RequirePackage{geometry}
\RequirePackage{anyfontsize}
\RequirePackage{tikz}

\DeclareOption{draft}{
	}
\ProcessOptions

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
\renewcommand{\normalsize}{\fontsize{0.01\paperwidth}{0.012\paperwidth}\selectfont}

\newlength\titlefontsize{}
\setlength{\titlefontsize}{0.04\paperheight}
\newlength\authorfontsize{}
\setlength{\authorfontsize}{0.02\paperheight}
\newlength\institutefontsize{}
\setlength{\institutefontsize}{0.014\paperheight}

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
\newcommand\overlayimg{}
\newcommand\overlay[1]{\renewcommand\overlayimg{#1}}

\AtBeginDocument{
	% title section
	\noindent\begin{minipage}{\textwidth}
		\begin{tikzpicture}[scale=0.0015\paperheight]
		\draw [ultra thick, draw=ornament, fill=ornament]
			(0,0) --(1.5,2) -- (4.5,2) -- (3,0) -- cycle;
		\end{tikzpicture}
		\textbf{{\fontsize{\titlefontsize}{\titlefontsize}\selectfont\textcolor{title} \@title}}
		\hspace{0.01\textwidth}
		\begin{tikzpicture}[scale=0.0015\paperheight]
		\draw [ultra thick, draw=ornament, fill=ornament]
			(0,0) --(0,2) -- (\textwidth,2) -- (\textwidth,0) -- cycle;
		\end{tikzpicture}
	\end{minipage}
	
	% header section
	\vspace{0.015\paperheight}
	\noindent\begin{minipage}{\textwidth}
	\headerstring
	\end{minipage}
	
	\noindent\rule{\textwidth}{1pt}
	\vfill
}

\AtEndDocument{
	\vfill
	\noindent\rule{\textwidth}{1pt}
	
	% footer section
	\noindent\begin{minipage}{\textwidth}
		\footerstring
	\end{minipage}
	
	%overlay
	\begin{tikzpicture}[remember picture, overlay]
	    \node[inner sep=0pt] at (current page.center) {%
	        \includegraphics[width=\paperwidth,height=\paperheight]{\overlayimg}%
	    };%
	\end{tikzpicture}
}