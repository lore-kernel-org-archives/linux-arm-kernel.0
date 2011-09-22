From: jgarzik@pobox.com (Jeff Garzik)
Date: Thu, 22 Sep 2011 14:12:02 -0400
Subject: [PATCH V7 1/5] AHCI Add the AHCI SATA feature on the MX53
	platforms
In-Reply-To: <CAJNCFVLm=bUMvXq7acke7Bd_tiV+b1=HjVp37KwtYyGsZHa+OQ@mail.gmail.com>
References: <1314762635-3923-1-git-send-email-richard.zhu@linaro.org>
	<1314762635-3923-2-git-send-email-richard.zhu@linaro.org>
	<20110920203037.GE31404@pengutronix.de>
	<CAJNCFVJ4EGQQ2CcRsPK6OidbU2uBEDertn8R9BuqxYGSBmxbPg@mail.gmail.com>
	<CAJNCFVLm=bUMvXq7acke7Bd_tiV+b1=HjVp37KwtYyGsZHa+OQ@mail.gmail.com>
Message-ID: <4E7B7A72.1020704@pobox.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/21/2011 03:05 AM, Richard Zhu wrote:
> Hi Sascha:
> One proposal about how to convert the ahci driver to devicetree in future.
> ahci driver system can make a reference to the evolution of the sdhc driver.
>
> * separate the ahci to ahci common codes, ahci-pci driver and
> ahci-platform driver.

We already have this, with libahci.

"libahci" == ahci common code
"ahci" == AHCI PCI driver
"ahci-platform" == AHCI platform driver

	Jeff
