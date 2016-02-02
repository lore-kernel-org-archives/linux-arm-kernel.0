From: Chris.Brandt@renesas.com (Chris Brandt)
Date: Tue, 2 Feb 2016 19:13:43 +0000
Subject: [PATCH 0/3] kallsyms: remove special handling for CONFIG_ARM
In-Reply-To: <CAKv+Gu9VvskQ34w0niS+6AtF9hNcycfYDt_3Kp4T+WK8Vxf_dA@mail.gmail.com>
References: <1454419174-21290-1-git-send-email-ard.biesheuvel@linaro.org>
 <HKXPR06MB0565A2CFF95AD7C000F43E6A8ADF0@HKXPR06MB0565.apcprd06.prod.outlook.com>
 <CAKv+Gu9VvskQ34w0niS+6AtF9hNcycfYDt_3Kp4T+WK8Vxf_dA@mail.gmail.com>
Message-ID: <HKXPR06MB056547567A1B02C73A13EEFE8ADF0@HKXPR06MB0565.apcprd06.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Are you getting any warnings/errors during the build?

Nothing. The build was clean.


And just to be safe, I did make clean, then make xipImage and re-flashed again.
Same result.


I'll see if I can step through and see exactly where it's dying.
I realize that no one really care about or tests XIP_KERNEL with ARMv7 at the moment, so I'll have to figure it out that some point. I just thought I'd let you know.


Chris
