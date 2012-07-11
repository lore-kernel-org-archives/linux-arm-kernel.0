From: stigge@antcom.de (Roland Stigge)
Date: Wed, 11 Jul 2012 15:39:09 +0200
Subject: [PATCH v2 04/23] ARM: LPC32xx: Add DMA configuration to platform
 data
In-Reply-To: <201207111325.03195.arnd@arndb.de>
References: <1339692673-7848-1-git-send-email-stigge@antcom.de>
 <201207111233.24780.arnd@arndb.de> <4FFD744F.8060204@antcom.de>
 <201207111325.03195.arnd@arndb.de>
Message-ID: <4FFD81FD.4080103@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/11/2012 03:25 PM, Arnd Bergmann wrote:
> On Wednesday 11 July 2012, Roland Stigge wrote:
>> OK, thanks!
>>
>> Is a patch on top of the already provided lpc32xx-next branches the
>> preferred form for a fix? On top of which branch do you need it?
>>
> 
> Yes, I think in this case, changing it on top of that branch is best.

Good, thanks!

> I'm not sure how that works for the nand drivers though, since they
> are in another tree.

Will address this separately with the mtd/nand tree.

Roland
