From: gnomes@lxorguk.ukuu.org.uk (One Thousand Gnomes)
Date: Tue, 20 May 2014 16:48:19 +0100
Subject: [PATCH] ARM: remove ARM710 specific assembler code
In-Reply-To: <20140517092337.GA67711@MacBook-Pro.local>
References: <1364507176.1345.45.camel@x61.thuisdomein>
 <8309592.drxAj71PnZ@wuerfel> <1400059550.31197.12.camel@x220>
 <4305975.PvMXZQ020k@wuerfel> <1400232598.20342.16.camel@x220>
 <20140516125545.GO3693@n2100.arm.linux.org.uk>
 <20140517092337.GA67711@MacBook-Pro.local>
Message-ID: <20140520164819.63357114@alan.etchedpixels.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> old features. Let's say in 10 years time we remove everything ARMv4,
> another 10 years ARMv5 and so on. We could make these milestones shorter
> but it really depends on what people use, we should not force them out
> of the kernel if still in use.

Why do you care ? Worry about it at the point nobody can remember needing
the support, or when it creates some horrible situation that is painful
to keep supporting and nobody seems to care. We've only recently dropped
80386 support, and we still support MC68000.

Or just wait until 2038 approaches and the 32bit panic stations begins,
then clean out 8)

Alan
