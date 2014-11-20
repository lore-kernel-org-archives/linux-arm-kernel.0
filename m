From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 20 Nov 2014 17:37:34 +0100
Subject: [GIT PULL] ARM: STi: DT changes for v3.19, round 2
In-Reply-To: <546B54A4.4050908@st.com>
References: <546B54A4.4050908@st.com>
Message-ID: <201411201737.34389.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 18 November 2014, Maxime Coquelin wrote:
> Hi Olof, Arnd and Kevin,
> 
> Please consider this second round of STi DT updates for v3.19.
> It is based on tag sti-dt-for-v3.19-1, already merged in arm-soc's next/dt.
> 
> The following changes since commit 43ca480c4e42f536fcf18118afcffad685e1292c:
> 
>    ARM: STi: DT: STiH407: Fix: clk-tmds-hdmi clock is missing 
> (2014-10-31 12:07:44 +0100)
> 
> are available in the git repository at:
> 
>    git://git.stlinux.com/devel/kernel/linux-sti.git tags/sti-dt-for-v3.19-2
> 
> for you to fetch changes up to 3ece2c2be34f2fe6254b49dffa5815e2fc7f1b71:
> 
>    ARM: STi: DT: STiH416: Change miphy356 node name to phy at fe382000 
> (2014-11-18 12:54:56 +0100)
> 
> ----------------------------------------------------------------
> STi DT updates for v3.19, round 2.
> 
> Highlights:
> -----------
>   - Refactor STiH407 SoC and board to add STiH410 SoC support
>   - Add USB support to STiH416 SoC
> 

Pulled into next/dt, thanks!

	Arnd
