From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 4 Feb 2011 14:24:41 +0100
Subject: [PATCH] mmci: calculate remaining bytes at error correctly
In-Reply-To: <20110203140031.GB14627@n2100.arm.linux.org.uk>
References: <1296137666-30906-1-git-send-email-linus.walleij@stericsson.com>
	<20110130212856.GA32737@n2100.arm.linux.org.uk>
	<20110130212939.GA384@n2100.arm.linux.org.uk>
	<AANLkTi=yj716us6bHFfGRwm2Q_iPEAJeQHDjB=3_pTe5@mail.gmail.com>
	<20110203003054.GA7068@n2100.arm.linux.org.uk>
	<20110203140031.GB14627@n2100.arm.linux.org.uk>
Message-ID: <AANLkTi=GKzkA_53Vo_=pc4fMhXCFpc088jcqe4AOgOSS@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/2/3 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> On Thu, Feb 03, 2011 at 12:30:54AM +0000, Russell King - ARM Linux wrote:
>> It looks to me like the data counter decrements according to bytes
>> transferred on the MMC bus.

Looks like that to me as well.

> Right, this is what I've presently got, which appears to resolve
> the issue for me. ?Ack?

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
