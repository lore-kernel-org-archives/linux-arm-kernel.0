From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Tue, 24 Mar 2015 07:45:39 +0100
Subject: [PATCH 5/7] ARM: dts: enable regulator support for i.MX23/i.MX28
In-Reply-To: <20150323183740.GI14954@sirena.org.uk>
References: <1426984203-9133-1-git-send-email-stefan.wahren@i2se.com>
 <1426984203-9133-6-git-send-email-stefan.wahren@i2se.com>
 <20150323060706.GB4946@pengutronix.de>
 <1469391177.549604.1427133274978.JavaMail.open-xchange@oxbaltgw02.schlund.de>
 <20150323183740.GI14954@sirena.org.uk>
Message-ID: <55110813.7010708@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

Am 23.03.2015 um 19:37 schrieb Mark Brown:
> On Mon, Mar 23, 2015 at 06:54:34PM +0100, Stefan Wahren wrote:
>>> Sascha Hauer <s.hauer@pengutronix.de> hat am 23. M?rz 2015 um 07:07
>>> It is very unusual to describe the regulators of a device on a register
>>> level like this and to iomemap each register individually. I think you
>>> should drop the registers here and put this knowledge into the driver
>>> like (nearly?) all others do.
>> do mean dropping the base address of the regulator, too?
>> How would you implement it (bare register address or regmap or syscon), since
>> there
>> are overlapping register regions for different driver?
>> @Mark: What's your opinion?
> This might be the sort of thing normally handled by a system controller,
> I have to say I had assumed this had all been discussed in the previous
> iterations of this seriee.

sorry, but i missed this important fact.

If you speak of system controller, do you mean the usage of
drivers/mfd/syscon.c ?

Stefan
