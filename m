From: avorontsov@dev.rtsoft.ru (Anton Vorontsov)
Date: Tue, 27 Jul 2010 21:11:09 +0400
Subject: [PATCH v3 0/4] SMP support for CNS3xxx + some SMP SCU cleanups
Message-ID: <20100727171109.GA7929@oksana.dev.rtsoft.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Russell,

These patches were posted before, i.e.

1/3 ARM: Factor out secondary CPU bootup code from VExpress platforms
 http://lists.infradead.org/pipermail/linux-arm-kernel/2010-June/018410.html
2/3 ARM: RealView: Switch to generic SCU routines
 http://lists.infradead.org/pipermail/linux-arm-kernel/2010-June/018411.html
3/3 ARM: cns3xxx: Add support for SMP
 http://lists.infradead.org/pipermail/linux-arm-kernel/2010-June/018412.html

In this updated series I split patch 1/3 into two, i.e. now it is:

1/4 ARM: SCU: Add generic routines for secondary CPU bootup
and
3/4 ARM: VExpress: Switch to generic SCU routines

This was done so that new feature addition doesn't depend on a
cleanup patch.

I tested 4/4 on a RealView PBX platform, so it should be pretty
much OK. 3/4 was only compile-tested, but it should be OK as
generic SCU code was mostly copied from VExpress platforms.

In the end, I consider patches 1/4 and 2/4 as 100% safe, so I'd
like them to go into 2.6.36 via your patch tracking system. What
do you think?

Thanks,

-- 
Anton Vorontsov
email: cbouatmailru at gmail.com
irc://irc.freenode.net/bd2
