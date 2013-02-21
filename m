From: javier.martin@vista-silicon.com (Javier Martin)
Date: Thu, 21 Feb 2013 13:19:19 +0100
Subject: [PATCH 0/3] crypto: sahara: Add support for SAHARA in i.MX27.
Message-ID: <1361449162-27302-1-git-send-email-javier.martin@vista-silicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series of patches provide AES-ECB and AES-CBC support
for the SAHARA2 cryptographic accelerator which is inside the i.MX27 SoC.
It is expected that more algorithms will be supported in the future.

For testing, a Visstrim M10 board has been used and the code related
to this platform has been included too.

[PATCH 1/3] i.MX27: Add platform support for SAHARA2.
[PATCH 2/3] crypto: sahara: Add driver for SAHARA2 accelerator.
[PATCH 3/3] Visstrim M10: Add support for SAHARA2 module.
