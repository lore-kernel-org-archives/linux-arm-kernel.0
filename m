From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Mon, 16 Jun 2014 22:05:23 +0200
Subject: PXA2xx and pinctrl
Message-ID: <87oaxsd3i4.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Haojian, Eric,

In my current work of porting things here and there to device-tree for PXA27x,
I'm considering mfp-pxa2xx for pinctrl integration.

I'm wondering if you see before hand any blocking point that can't be addressed
and which prevents pxa2xx to be converted to pinctrl inftrastructure.

And if no blocking point arises, how easy would it be according to your
knowledge to still offer legacy mfp_* APIs, and replace the functions by
pinctrl_*() calls ?

Cheers.

-- 
Robert
