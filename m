From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 03 Jan 2017 17:19:17 +0100
Subject: [PATCH 0/8] ARM: dts: Switch to new DSA binding
In-Reply-To: <20170102022249.10657-1-f.fainelli@gmail.com> (Florian Fainelli's
 message of "Sun, 1 Jan 2017 18:22:41 -0800")
References: <20170102022249.10657-1-f.fainelli@gmail.com>
Message-ID: <87eg0kf75m.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Florian,
 
 On lun., janv. 02 2017, Florian Fainelli <f.fainelli@gmail.com> wrote:

> Hi all,
>
> This patch series converts the in-tree users to utilize the new (relatively)
> DSA binding that was introduced with commit 8c5ad1d6179d ("net: dsa: Document
> new binding"). The legacy binding node is kept included, but is marked
> disabled.
>
> In about 2-3 releases we may consider removing the old DSA binding entirely
> from the kernel.

The series looks OK. However I would like to have a reviewed by from
Andrew who know well the mvebu platform and the DSA subsystem.

Also there's few fixes needed for the v2.

Thanks,

Gregory

>
> Thank you!
>
> Florian Fainelli (8):
>   ARM: dts: armada-370-rd: Utilize new DSA binding
>   ARM: dts: armada-38x: Utilize new DSA binding
>   ARM: dts: armada-388-clearfog: Utilize new DSA binding
>   ARM: dts: armada-xp-linksys-mamba: Utilize new DSA binding
>   ARM: dts: kirkwood-dir665: Utilize new DSA binding
>   ARM: dts: kirkwood-linksys-viper: Utilize new DSA binding
>   ARM: dts: kirkwood-mv88f6281gtw-ge: Utilize new DSA binding
>   ARM: dts: kirkwood-rd88f6281: Utilize new DSA binding
>
>  arch/arm/boot/dts/armada-370-rd.dts            | 44 +++++++++++++++++
>  arch/arm/boot/dts/armada-385-linksys.dtsi      | 52 ++++++++++++++++++++-
>  arch/arm/boot/dts/armada-388-clearfog.dts      | 65 ++++++++++++++++++++++++++
>  arch/arm/boot/dts/armada-xp-linksys-mamba.dts  | 53 +++++++++++++++++++++
>  arch/arm/boot/dts/kirkwood-dir665.dts          | 49 +++++++++++++++++++
>  arch/arm/boot/dts/kirkwood-linksys-viper.dts   | 49 +++++++++++++++++++
>  arch/arm/boot/dts/kirkwood-mv88f6281gtw-ge.dts | 49 +++++++++++++++++++
>  arch/arm/boot/dts/kirkwood-rd88f6281-z0.dts    | 11 +++++
>  arch/arm/boot/dts/kirkwood-rd88f6281.dtsi      | 44 +++++++++++++++++
>  9 files changed, 415 insertions(+), 1 deletion(-)
>
> -- 
> 2.9.3
>

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
