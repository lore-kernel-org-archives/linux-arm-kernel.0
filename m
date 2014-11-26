From: al.kochet@gmail.com (Alexander Kochetkov)
Date: Wed, 26 Nov 2014 15:25:29 +0300
Subject: [PATCH 2/3] i2c: slave-eeprom: add eeprom simulator driver
In-Reply-To: <20141122181229.GB9698@katana>
References: <1416326695-13083-1-git-send-email-wsa@the-dreams.de>
 <1416326695-13083-3-git-send-email-wsa@the-dreams.de>
 <CAOY=C6FSXWn2AKn9gp0oU69U8VkkyJAE7MMUTZsToy0P_Tf6AA@mail.gmail.com>
 <20141122181229.GB9698@katana>
Message-ID: <2A7C987F-15E0-46FD-A711-E7F5BA9893FC@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


22 ????. 2014 ?., ? 21:12, Wolfram Sang <wsa@the-dreams.de> ???????(?):

> IMO a repeated start is to ensure that two messages arrive at the slave
> without interruption from another master. I can't think why a slave
> should know which type of start that was. In fact, if it does that would
> raise an eyebrow for me. Do you have an example?

It is used to implement Device ID reading.
Not sure, that the feature is really needed for the first release.

See [1] "3.1.17 Device ID" chapter on page "20 of 64"
See [2] "7.2.2 Device ID (PCA9671 ID field)" chapter

[1] UM10204 I2C-bus specification and user manual (http://www.nxp.com/documents/user_manual/UM10204.pdf)
[2] PCA9671 (http://www.nxp.com/documents/data_sheet/PCA9671.pdf)

Alexander.
