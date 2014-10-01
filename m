From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 1 Oct 2014 17:07:02 +0200
Subject: [GIT PULL] ARM: STi: DT changes for v3.18
In-Reply-To: <54215982.2040909@st.com>
References: <54215982.2040909@st.com>
Message-ID: <201410011707.02238.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 23 September 2014, Maxime Coquelin wrote:
> Highlights:
> -----------
>  - Add SDHCI support for STiH41x B2020 boards
>  - Add reset controllers to STiH407 SoC
>  - Add MiPHY & SATA support to STiH416
>  - Add Thermal supportto STiH416
>  - Add Clock support to STiH407 SoC
> 
> Note that this pull request contains merge from Philipp Zabel's reset tree for STiH407 reset DT bindings includes.


Pulled into the next/late branch. If we end up sending a pull request for the
late stuff this time, that also gives Philipp time to go first with his
branches.

Unfortunately, your submission came a bit late, so no guarantee this is going
to make it into 3.18. If we see too many regressions with the earlier branches,
we'll defer it for 3.19.

	Arnd
