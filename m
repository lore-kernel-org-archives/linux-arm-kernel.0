From: nico@fluxnic.net (Nicolas Pitre)
Date: Mon, 14 Feb 2011 13:26:48 -0500 (EST)
Subject: [PATCH 2/4] arm: configs: update mmp2 defconfig for brownstone and
	SoC Selection
In-Reply-To: <04A50A49-CBBC-4E5D-B19E-391B4DF77DF3@marvell.com>
References: <04A50A49-CBBC-4E5D-B19E-391B4DF77DF3@marvell.com>
Message-ID: <alpine.LFD.2.00.1102141320410.14920@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 13 Feb 2011, Philip Rakity wrote:

> 
> took old mmp2_defconfig --
> did make menuconfig
> changed to CPU_MMP2
> added brownstone as supported board
> 
> Signed-off-by: Philip Rakity <prakity@marvell.com>
> ---
>  arch/arm/configs/mmp2_defconfig | 1207 ++++++++++++++++++++++++++++++++++++++-
>  1 files changed, 1203 insertions(+), 4 deletions(-)

That's not good.

You should do a "make savedefconfig" which will produce a ./defconfig 
file which is a reduced version of your config.  Then use that instead 
of the .config file to update your default config.


Nicolas
