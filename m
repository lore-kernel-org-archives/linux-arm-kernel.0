From: davem@davemloft.net (David Miller)
Date: Wed, 30 Sep 2015 08:40:39 -0700 (PDT)
Subject: [PATCH v2 0/7] net: mvneta: Switch to per-CPU irq and make
 rxq_def useful
In-Reply-To: <alpine.DEB.2.11.1509301655140.4500@nanos>
References: <1443197378-30717-1-git-send-email-gregory.clement@free-electrons.com>
 <20150929.115157.1923947727727463035.davem@davemloft.net>
 <alpine.DEB.2.11.1509301655140.4500@nanos>
Message-ID: <20150930.084039.1788742148434227487.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thomas Gleixner <tglx@linutronix.de>
Date: Wed, 30 Sep 2015 16:56:06 +0200 (CEST)

> On Tue, 29 Sep 2015, David Miller wrote:
>> From: Gregory CLEMENT <gregory.clement@free-electrons.com>
>> Date: Fri, 25 Sep 2015 18:09:31 +0200
>> 
>> > As stated in the first version: "this patchset reworks the Marvell
>> > neta driver in order to really support its per-CPU interrupts, instead
>> > of faking them as SPI, and allow the use of any RX queue instead of
>> > the hardcoded RX queue 0 that we have currently."
>> 
>> Series applied, thanks.
> 
> You could have had the courtesy to wait for an ack for the core irq
> parts at least....

Sorry, my impression was that those parts were already discussed and
agreed upon.
