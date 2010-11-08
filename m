From: marco.stornelli@gmail.com (Marco Stornelli)
Date: Mon, 8 Nov 2010 12:59:06 +0100
Subject: [PATCH] arm: fix compilation warning during compilation
In-Reply-To: <20101108091302.GO16938@pengutronix.de>
References: <4CD51A9B.7010806@gmail.com>
	<20101108091302.GO16938@pengutronix.de>
Message-ID: <AANLkTinmQtrLJcjxRSwbHARrgE-4FEaJeDt4R8C2tLHY@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/11/8 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:
> Hello,
>
> On Sat, Nov 06, 2010 at 10:06:35AM +0100, Marco Stornelli wrote:
>> From: Marco Stornelli <marco.stornelli@gmail.com>
>>
>> During compilation of 2.6.36 for Beagle board, there a are a couple of warnings. This patch fix them.
> Please break lines for commit logs at around 76 chars and mention the
> exact compiler warning being fixed.
>

My compiler version is gcc 4.4.1. Two warning: variable gpio_mux may
be used not initialized (false positive, I agree); second: compiler
fix the void lack in the inline function with an int. Obviously there
is a lack of return type that it must be void.

Regards,

Marco
