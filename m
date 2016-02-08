From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon, 08 Feb 2016 16:49:40 +0100
Subject: [PATCH 0/2] ARM: mvebu: misc DT improvements
In-Reply-To: <1453908287-29557-1-git-send-email-thomas.petazzoni@free-electrons.com>
 (Thomas Petazzoni's message of "Wed, 27 Jan 2016 16:24:45 +0100")
References: <1453908287-29557-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <87pow719t7.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,
 
 On mer., janv. 27 2016, Thomas Petazzoni <thomas.petazzoni@free-electrons.com> wrote:

> Hello,
>
> Here are two fixes/improvements for Marvell EBU platforms, which were
> initially sent on June 18th 2015, and never got any feedback.
>
> This new iteration is simply rebased on v4.5-rc1 with no other
> changes.

Could you send a new version taking into account the comment from
Andrew?

Thanks,

Gregory

>
> Thanks!
>
> Thomas
>
> Lior Amsalem (1):
>   ARM: mvebu: use armada-370-sata for SATA on Armada 375
>
> Thomas Petazzoni (1):
>   ARM: mvebu: add NAND description to Armada 370 DB and Armada XP DB
>
>  arch/arm/boot/dts/armada-370-db.dts | 21 +++++++++++++++++++++
>  arch/arm/boot/dts/armada-375.dtsi   |  2 +-
>  arch/arm/boot/dts/armada-xp-db.dts  | 21 +++++++++++++++++++++
>  3 files changed, 43 insertions(+), 1 deletion(-)
>
> -- 
> 2.6.4
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
