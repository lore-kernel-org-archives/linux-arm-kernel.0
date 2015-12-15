From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 15 Dec 2015 17:48:05 +0100
Subject: [PATCH 0/2] Dove GPU support
In-Reply-To: <1450197483-31441-1-git-send-email-l.stach@pengutronix.de> (Lucas
 Stach's message of "Tue, 15 Dec 2015 17:38:01 +0100")
References: <1450197483-31441-1-git-send-email-l.stach@pengutronix.de>
Message-ID: <87a8pbvet6.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lucas,
 
 On mar., d?c. 15 2015, Lucas Stach <l.stach@pengutronix.de> wrote:

> Hi Dove maintainers,
>
> those 2 patches add support for the Vivante GPU. The binding has already been
> acked by the DT maintainers and is included in the pull request for the DRM
> driver. I hope you can pick those patches up for inclusion in 4.5.

Good timing! I was about to ask news about these pacthes.

They are both applied on mvebu/dt

Thanks,

Gregory


>
> Regards,
> Lucas
>
> Russell King (2):
>   ARM: dts: dove: add DT GPU support
>   ARM: dts: enable GPU for SolidRun's Cubox
>
>  arch/arm/boot/dts/dove-cubox.dts |  8 ++++++++
>  arch/arm/boot/dts/dove.dtsi      | 16 ++++++++++++++++
>  2 files changed, 24 insertions(+)
>
> -- 
> 2.6.2
>

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
