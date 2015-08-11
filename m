From: aph@redhat.com (Andrew Haley)
Date: Tue, 11 Aug 2015 09:58:00 +0100
Subject: [RFC PATCH 01/10] arm64: feature registers: Documentation
In-Reply-To: <55C9B51D.1060601@arm.com>
References: <1437731037-25795-1-git-send-email-suzuki.poulose@arm.com>
 <1437731037-25795-2-git-send-email-suzuki.poulose@arm.com>
 <20150810160636.GB15394@e104818-lin.cambridge.arm.com>
 <55C8E12E.6030305@arm.com> <55C8EB17.7090708@redhat.com>
 <55C9B51D.1060601@arm.com>
Message-ID: <55C9B918.90807@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/08/15 09:41, Suzuki K. Poulose wrote:
> The REVIDR has to be used in conjunction with the MIDR to make real sense.

Sure, of course.

> We cannot guarantee that the REVIDR that we read (would) belong to the CPU
> where MIDR would have been read (unless the process is pinned) and hence the
> user may not be able to make any use of the information.

Well, yes, nothing is perfect.  The situation we're in now, for example,
is that if we see Cortex A57 we have to assume Cortex A53 and include
workarounds.  People might mix and match processors.  So it goes.

> Steve has a patch [1]
> to expose the MIDR,REVIDR info via sysfs.
> 
> [1] https://lkml.org/lkml/2015/7/24/420

OK.  As long as I can get at it I'm happy.

Andrew.
