From: zajec5@gmail.com (=?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=)
Date: Thu, 25 Sep 2014 07:48:09 +0200
Subject: [PATCH v5 1/2] bcma: register bcma as device tree driver
In-Reply-To: <1411597048-25470-1-git-send-email-hauke@hauke-m.de>
References: <1411597048-25470-1-git-send-email-hauke@hauke-m.de>
Message-ID: <CACna6rx7d56-94Tsn=rb+FaS89DYZuvA1ZOFoSpRVCsVvPvWZA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25 September 2014 00:17, Hauke Mehrtens <hauke@hauke-m.de> wrote:
> This driver is used by the bcm53xx ARM SoC code. Now it is possible to
> give the address of the chipcommon core in device tree and bcma will
> search for all the other cores.

Hauke: I just noticed you sent this V5 patch as 1/2. I was wondering
if it makes a sense to treat it as a standalone patch? Should we ask
John to pick this one and you could work on this IRQ stuff
independently?
