From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Thu, 15 Jul 2010 15:47:57 +0200
Subject: [PATCH 2/3] ARM: register character LCD for PB1176
In-Reply-To: <20100715115631.GG29322@n2100.arm.linux.org.uk>
References: <1278429678-4837-1-git-send-email-triad@df.lth.se>
	<20100715115631.GG29322@n2100.arm.linux.org.uk>
Message-ID: <AANLkTinQEu9Dm5V-8JCQDgbtfGy6jZ-1bLncYSILKuys@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/7/15 Russell King - ARM Linux <linux@arm.linux.org.uk>:

> On Tue, Jul 06, 2010 at 05:21:18PM +0200, Linus Walleij wrote:
>> This registers the character LCD device for the ARM RealView
>> PB1176.
>
> Shouldn't ARM_CHAR_LCD be a stand-alone option, rather than something
> which is always built-in whenever one of these platforms is enabled?

OK I'll break that out when I move it to drivers/misc.

Yours,
Linus Walleij
