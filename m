From: andreas@kemnade.info (Andreas Kemnade)
Date: Thu, 27 Sep 2018 16:59:56 +0200
Subject: [GIT PULL 3/3] dts changes for omaps for v4.20
In-Reply-To: <pull-1537983432-167273@atomide.com-3>
References: <pull-1537983432-167273@atomide.com>
 <pull-1537983432-167273@atomide.com-3>
Message-ID: <20180927165956.1fa539de@kemnade.info>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, 26 Sep 2018 10:40:45 -0700
Tony Lindgren <tony@atomide.com> wrote:

> From: "Tony Lindgren" <tony@atomide.com>
> 
> The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:
> 
>   Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.20/dt-signed
> 
> for you to fetch changes up to e4ab928957a3173d5d8e7fc78df6a3a63be0f60d:
> 
>   ARM: dts: omap3-gta04: add pulldown/up settings for twl4030 gpio (2018-09-24 15:17:14 -0700)
> 
> ----------------------------------------------------------------
> Devicetree changes for omap variants
> 
> This branch contains a series of improvments for omap3-gta04 phone,
> and a series of clean-up for am335x to remove the deprecated phy_id
> property.
> 
> The rest is to configure am57xx-idk boards for leds, load trigger,
> and smps, am3517-evm audio configuration, beaglebone hdmi cec support,
> coresight binding update, and fixes for i2c and spi warnings.
> 
> ----------------------------------------------------------------
[...]
> H. Nikolaus Schaller (32):
[...]
>       ARM: dts: omap3-gta04a5one: define GTA04A5 variant with OneNAND
That new file was not added no the makefile. Somehow that got lost
 and I thought a separate patch was sent by Nikolaus as a straggler but
I cannot find it at the moment.

Regards,
Andreas
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 833 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180927/5f0b96fb/attachment.sig>
