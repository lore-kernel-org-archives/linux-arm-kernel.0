From: shawn.guo@freescale.com (Shawn Guo)
Date: Sun, 24 Jul 2011 11:44:19 +0800
Subject: [PATCH v6 0/6] mc13783: add pwr button support
In-Reply-To: <1311344232-29902-1-git-send-email-philippe.retornaz@epfl.ch>
References: <1311344232-29902-1-git-send-email-philippe.retornaz@epfl.ch>
Message-ID: <20110724034418.GA28189@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 22, 2011 at 04:17:06PM +0200, Philippe R?tornaz wrote:
> Hello
> 
> This add button handling for the MC13783 PMIC.
> 
> Patch 1 & 2 modify the mc13xxx MFD driver to use the platform data to
> resgister the led subdevice and unconditionally register the regulator
> subdevice (as suggested by Mark and Uwe).
> 
> Patch 3 remove the use of the *_USE_REGULATOR and *_USE_LED macros in
> the platform files.
> 
> Patch 4 must be applied after patch 1,2,3 to remove the obsolete define.
> 
> Patch 5 modify the mc13xxx MFD driver to add a button subdevice and
> also adds the mc13783-pwrbutton driver using a misc input device.
> 
> The last patch adds the power on button support to the mx31moboard boards.
> 
> v2: first patch modified according to comments by Dmitry Torokhov
> v3: Implement review by Uwe
> v4: Implement comments by Uwe and Mark
> v5: Reorder patchset
> v6: Minor corrections
> 
It seems you did not address the comment about possible NULL pdata I
put on v4?

-- 
Regards,
Shawn
