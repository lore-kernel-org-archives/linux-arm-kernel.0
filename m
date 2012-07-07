From: jgq516@gmail.com (Xiao Jiang)
Date: Sat, 7 Jul 2012 08:10:57 +0800
Subject: [PATCH 1/1] ARM: add PROC_DEVICETREE support in Kconfig
In-Reply-To: <CAOesGMjmeXVx2MR7GGux9Cztkf-C3cBqpBW1_PW75D_Gk0GHiA@mail.gmail.com>
References: <1341571127-14461-1-git-send-email-jgq516@gmail.com>
 <4FF6DCCA.2080509@gmail.com>
 <CAERv70uZMEoX4OcECssOrktVzC911tiSLXRH56TjyhQqVgNwBA@mail.gmail.com>
 <CAOesGMjmeXVx2MR7GGux9Cztkf-C3cBqpBW1_PW75D_Gk0GHiA@mail.gmail.com>
Message-ID: <CAERv70vi6-OanH2p9Db0jy-zLVVeNa+dfC04aYrsd_3m7OydLQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2012/7/7 Olof Johansson <olof@lixom.net>

> On Fri, Jul 6, 2012 at 4:15 PM, Xiao Jiang <jgq516@gmail.com> wrote:
> > 2012/7/6 Rob Herring <robherring2@gmail.com>
> >>
> >> On 07/06/2012 05:38 AM, jgq516 at gmail.com wrote:
> >> > From: Xiao Jiang <jgq516@gmail.com>
> >> >
> >> > Since more and more arm chips support device tree, it'd be better add
> >> > PROC_DEVICETREE
> >> > in arch/arm/Kconfig to avoid duplicate code.
> >>
> >> I think this should remain user choice. If its going to be selected,
> >> then you might as well just remove the option altogether. Perhaps just
> >> make the option default to yes.
> >>
> > Hmm, sounds reasonable from your point. So the better choice is to set
> the
> > option default to Y if the board has dt support just like tegra_defconfig
> > and at91_dt_defconfig,  right? thanks.
>
> Why bother? If the defconfigs select it then most users basing their
> config from that will be just fine.
>
> PROC_DEVICETREE is 100% optional, it's useful to get runtime access to
> the contents of the device tree but it's not required for the kernel
> to boot.
>
> Got it, thanks.

Regards,
Xiao

>
> -Olof
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120707/e1b4c8b6/attachment-0001.html>
