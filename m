From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 23 May 2014 22:44:08 +0200
Subject: ARM: STi: DT changes for v3.16, v3
In-Reply-To: <537DBEC6.7020909@st.com>
References: <537DBEC6.7020909@st.com>
Message-ID: <201405232244.08531.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 22 May 2014, Maxime Coquelin wrote:
> Hi Olof, Kevin and Arnd,
> 
> Please consider these STi DT updates for v3.16.
> 
> This 3rd version takes into account Olof's comments on the v2:
>         - Fix upper-cases in labels and node names
>         - Sort compatibles order from specific to generic
>         - Sort dts entries in Makefile
> 
> It also adds support for the B2020 revision E board for STiH416 SoC.
> 
> Note that two reset patches are part of this pull request, in order to avoid
> compilation breakage.
> Adding these two patches in this pull request has been accepted by Philipp Zabel.
> 

Please include the description you want to see in the git history for
the merge in the tag text, and if possible sign the tag.

I've copied the text from your email here and merged it into next/dt.

	Arnd
