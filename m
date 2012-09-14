From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 14 Sep 2012 07:57:34 +0000
Subject: [PATCH 1/2] ARM: SoC: convert MSM SMP to SoC descriptor
In-Reply-To: <20120913161548.GA11395@codeaurora.org>
References: <1347461906-13527-7-git-send-email-arnd@arndb.de>
 <201209130847.20087.arnd@arndb.de> <20120913161548.GA11395@codeaurora.org>
Message-ID: <201209140757.34393.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 13 September 2012, David Brown wrote:
> Olof wanted me to try and split the msm-for-3.7 into a few branches,
> so I'm going to work on that this morning.  I'm not quite sure how
> well it will work, since, for example, most of the cleanups are
> preparing the tree for the devicetree changes.

That is the common scenario. What you should do there is to have
one cleanup branch that collects all the cleanups from the other
branches, and then base each of the other branches on top of that.

	Arnd
