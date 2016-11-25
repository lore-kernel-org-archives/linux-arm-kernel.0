From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 25 Nov 2016 16:17:04 +0100
Subject: [PATCH RESEND 2/2] gpio: axp209: add pinctrl support
In-Reply-To: <20161123141151.25315-3-quentin.schulz@free-electrons.com>
References: <20161123141151.25315-1-quentin.schulz@free-electrons.com>
 <20161123141151.25315-3-quentin.schulz@free-electrons.com>
Message-ID: <20161125151704.3am7wyqrlz767dvc@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Nov 23, 2016 at 03:11:51PM +0100, Quentin Schulz wrote:
> The GPIOs present in the AXP209 PMIC have multiple functions. They
> typically allow a pin to be used as GPIO input or output and can also be
> used as ADC or regulator for example.[1]
> 
> This adds the possibility to use all functions of the GPIOs present in
> the AXP209 PMIC thanks to pinctrl subsystem.
> 
> [1] see registers 90H, 92H and 93H at
>     http://dl.linux-sunxi.org/AXP/AXP209_Datasheet_v1.0en.pdf
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>

I've said it already face to face, but ideally you should split that
patch into logical changes.

I can see here at least three:
  - Adding the pinctrl features
  - Renaming the structure and functions
  - Removal of a few functions

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161125/3ba59778/attachment.sig>
