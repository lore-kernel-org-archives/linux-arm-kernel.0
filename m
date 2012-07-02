From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 2 Jul 2012 15:30:23 +0000
Subject: [PATCH v6] arm: Add basic support for new Marvell Armada 370 and
 Armada XP SoC
In-Reply-To: <1341228809-17824-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1341228809-17824-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <201207021530.23809.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 02 July 2012, Thomas Petazzoni wrote:
> You'll find in this patch set the sixth version of the initial support
> for a new family of ARMv7-compatible Marvell SoCs.
> 
> Do you think this patch set has a chance of hitting the 3.6 merge
> window?

Yes, definitely.

> We are willing to quickly resubmit updated versions to take into
> account new comments. We have a lot more code to support those new
> SoCs, and we would like to make progress in submitting those other
> parts for the mainline.

I think it's time to just take your current version into arm-soc
and do all other patches on top. I'll wait for an Ack from
Ben, Andrew and Andrew first though.

	Arnd
