From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 27 Jan 2015 16:09:19 +0100
Subject: [PATCH v3] ARM: dts: sun4i: Add initial dts for Gemei G9 tablet
In-Reply-To: <1422295208-11016-1-git-send-email-plaes@plaes.org>
References: <1422295208-11016-1-git-send-email-plaes@plaes.org>
Message-ID: <20150127150919.GI7200@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 26, 2015 at 08:00:06PM +0200, Priit Laes wrote:
> Gemei G9 is an A10 based tablet, with 1G RAM, 16G NAND, 1024x768
> IPS LCD display, stereo speakers, 1.3MP front camera and 5 MP
> rear camera, 8000mAh battery, GT901 2+1 touchscreen, Bosch BMA250
> accelerometer and RTL8188CUS USB wifi. It also has MicroSD slot,
> miniHDMI, 1 x MicroUSB OTG port and 1 x MicroUSB host port and
> 3.5mm headphone jack.
> 
> Changes since v2:
>  * Fix syntax error (brown paper bag release)
> 
> Changes since v1:
>  * Added sun4i-lradc keymap
>  * Added TODO note about missing IRQ pins for bma250
>  * Fixed formatting issues and removed external URLs
> 
> Signed-off-by: Priit Laes <plaes@plaes.org>

Applied, thanks!

Note that it will probably show up in 3.21. I sent the pull request
this weekend, and unless something major and unexpected shows up, I
don't plan on making new ones.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150127/291e23b7/attachment.sig>
