From: olof@lixom.net (Olof Johansson)
Date: Thu, 4 Jan 2018 22:52:22 -0800
Subject: [GIT PULL] Second Round of Renesas ARM Based SoC Updates for v4.16
In-Reply-To: <cover.1513936182.git.horms+renesas@verge.net.au>
References: <cover.1513936182.git.horms+renesas@verge.net.au>
Message-ID: <20180105065222.zwpoyylkdjgl2rog@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 22, 2017 at 11:30:37AM +0100, Simon Horman wrote:
> Hi Olof, Hi Kevin, Hi Arnd,
> 
> Please consider these second round of Renesas ARM based SoC updates for v4.16.
> 
> This pull request is based on the previous round of
> such requests, tagged as renesas-soc-for-v4.16,
> which I have already sent a pull-request for.
> 
> 
> The following changes since commit 90f0d2b344313a8a4c366ef60d0df33008d2be84:
> 
>   soc: renesas: Identify R-Car M3-W ES1.1 (2017-11-27 11:40:57 +0100)
> 
> are available in the git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-soc2-for-v4.16
> 
> for you to fetch changes up to 91c719f5ec6671f7b63762d78897af5583dd7693:
> 
>   soc: renesas: rcar-sysc: Keep wakeup sources active during system suspend (2017-12-20 11:16:05 +0100)
> 
> ----------------------------------------------------------------
> Second Round of Renesas ARM Based SoC Updates for v4.16
> 
> * rcar-sysc: Keep wakeup sources active during system suspend
> 
>   Geert Uytterhoeven says "If an R-Car SYSC slave device is part of the
>   CPG/MSTP or CPG/MSSR Clock Domain and to be used as a wakeup source, it
>   must be kept active during system suspend.
> 
>   Currently this is handled in device-specific drivers by explicitly
>   increasing the use count of the module clock when the device is
>   configured as a wakeup source.  However, the proper way to prevent the
>   device from being stopped is to inform this requirement to the genpd
>   core, by setting the GENPD_FLAG_ACTIVE_WAKEUP flag.
> 
>   Note that this will only affect devices configured as wakeup sources."

Merged, thanks.


-Olof
