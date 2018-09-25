From: olof@lixom.net (Olof Johansson)
Date: Tue, 25 Sep 2018 13:40:14 -0700
Subject: [GIT PULL] ARM: at91: DT for 4.20
In-Reply-To: <20180925104226.GA32034@piout.net>
References: <20180925104226.GA32034@piout.net>
Message-ID: <20180925204014.ys7gpxssghmrq3wx@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 25, 2018 at 12:42:26PM +0200, Alexandre Belloni wrote:
> Arnd, Olof,
> 
> Here are the DT changes for 4.20. Mostly cleanups and small additions.
> 
> The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:
> 
>   Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/at91/linux tags/at91-4.20-dt
> 
> for you to fetch changes up to 97181516b0785dd032700ae4899842389c6bea78:
> 
>   arm: dts: sama5d2: Update coresight bindings for hardware ports (2018-09-19 19:12:25 +0200)
> 
> ----------------------------------------------------------------
> AT91 DT for 4.20
> 
>  - warning fiwes from Rob
>  - many updates for the axentia boards
>  - ADC, I2S and touch screen support for sama5d2

Merged, thanks!

Tiny nit:

> Suzuki K Poulose (1):
>       arm: dts: sama5d2: Update coresight bindings for hardware ports

s/arm/ARM/


-Olof
