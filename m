From: mfuzzey@parkeon.com (Martin Fuzzey)
Date: Mon, 23 Mar 2015 11:13:21 +0100
Subject: mc34708 regulators
Message-ID: <550FE741.9080709@parkeon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Steffen,

I see you have added the regulator definitions for the mc34708 to the 
imx53-qsrb device tree.

However there doesn't seem to be a regulator driver for this PMIC in the 
tree.

mc13xxx supports parts of the functionalities (like the rtc) but only 
seems to support mc13783 and mc13892 on the regulator side.

Am I missing something?

Is there a patch floating around for this?

Regards,

Martin
