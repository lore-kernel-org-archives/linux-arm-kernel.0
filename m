From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon, 08 Aug 2016 17:05:50 +0200
Subject: [GIT PULL] ARM: mvebu: dt-late for v4.8
In-Reply-To: <87popznp93.fsf@free-electrons.com> (Gregory CLEMENT's message of
 "Wed, 27 Jul 2016 16:12:56 +0200")
References: <87popznp93.fsf@free-electrons.com>
Message-ID: <87lh07uwq9.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,
 
 On Wed, Jul 27 2016, Gregory CLEMENT <gregory.clement@free-electrons.com> wrote:

> Hi,
>
> Here is a late pull request for a device tree fix on mvebu for v4.8.
>
> If it is too late to have it for v4.8-rc1, I will send it again as fix
> for v4.8-rc2.

So it was too late. Then I will do a pull request for the fix this week with
this patch.

Gregory


>
> Thanks,
>
> Gregory
>
> The following changes since commit d261861ab52623e34a25fe6ae76714456edda033:
>
>   ARM: dts: armada-388-clearfog: remove duplicate mdio entry (2016-07-11 18:05:48 +0200)
>
> are available in the git repository at:
>
>   git://git.infradead.org/linux-mvebu.git tags/mvebu-dt-late-4.8
>
> for you to fetch changes up to 1f5b6fd2942ca2a063655fbeea5a922bc08f9e21:
>
>   ARM: dts: armada388-clearfog: number LAN ports properly (2016-07-27 15:12:02 +0200)
>
> ----------------------------------------------------------------
> Late mvebu dt for v4.8
>
> The commit correct the led name on the clearfog board and should be
> applied as soon as possible to avoid spread the port renumbering over
> a large range of kernels.
>
> ----------------------------------------------------------------
> Russell King (1):
>       ARM: dts: armada388-clearfog: number LAN ports properly
>
>  arch/arm/boot/dts/armada-388-clearfog.dts | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
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
