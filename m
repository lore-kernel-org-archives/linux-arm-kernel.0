From: kpa_info@yahoo.fr (Patrick)
Date: Wed, 26 May 2010 12:00:19 +0000 (GMT)
Subject: 18bpp display on OMAP3
Message-ID: <667948.10985.qm@web29003.mail.ird.yahoo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello all,

I am currently designing a new board based on OMAP3530 (Gumstix) with a 18bpp touchscreen. According to the Ti Technical Ref. Manual (page 2164) the Display controller support two packing mode: the "Loosely Packed" that use 24bits buts only the 6 MSB bits of each color and the "Packed" mode that compact?all the 18bpp.

I would like to know which mode is recommended to use depending on the fb driver and eventually on the POWERVR SGX driver.

Thanks in advance for your help

Patrick




      
