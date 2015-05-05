From: thierry.reding@gmail.com (Thierry Reding)
Date: Tue, 5 May 2015 14:31:19 +0200
Subject: [PATCH 9/9] ARM: tegra: apalis t30: fix pin muxing and add HDA
 in device tree
In-Reply-To: <94ae838321940e1a245c115009f6c48f0eceee76.1428700856.git.marcel.ziswiler@toradex.com>
References: <cover.1428700856.git.marcel.ziswiler@toradex.com>
 <94ae838321940e1a245c115009f6c48f0eceee76.1428700856.git.marcel.ziswiler@toradex.com>
Message-ID: <20150505123117.GH30501@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 10, 2015 at 11:36:04PM +0200, Marcel Ziswiler wrote:
> From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> Fix pin muxing, add digital audio aka HDA pin muxing and activate HDA
> driver.
> Fix pu vs. gpio_pu pin muxing.
> While at it also update comment about supported module hardware
> versions.
> While at it also add an emmc label to the SDHCI node just like on
> Colibri T30.
> While at it set the dr_mode of the primary USB EHCI instance to OTG as
> well.
> 
> Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Same as for patch 8/9, please split these up into smaller patches that
do one thing each. And again, I'm not sure adding an emmc label just for
consistency here is worth it. If it's never used there's no need to have
it.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150505/3912c70f/attachment.sig>
