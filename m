From: will.deacon@arm.com (Will Deacon)
Date: Tue, 31 Aug 2010 10:31:29 +0100
Subject: [PATCH 3/3] x86: oprofile: fix oprofile_arch_init behaviour on
	failure
In-Reply-To: <20100831090518.GZ22783@erda.amd.com>
References: <1283107921-21464-1-git-send-email-will.deacon@arm.com>
	<1283107921-21464-2-git-send-email-will.deacon@arm.com>
	<1283107921-21464-3-git-send-email-will.deacon@arm.com>
	<1283107921-21464-4-git-send-email-will.deacon@arm.com>
	<20100830090929.GU22783@erda.amd.com>
	<1283244880.645.17.camel@e102144-lin.cambridge.arm.com>
	<20100831090518.GZ22783@erda.amd.com>
Message-ID: <1283247089.4063.2.camel@e102144-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2010-08-31 at 10:05 +0100, Robert Richter wrote:
> On 31.08.10 04:54:40, Will Deacon wrote:
> > Do you think it would be better to rework this patch so that the static
> > using_nmi variable is set explicitly by init.c, or shall I just drop
> > this patch altogether (and resubmit the first two)?
> 
> For x86 wont change the code (actually I found a bug in the init_sysfs
> error handler for which I will send a fix). Just wanted to get your
> confirmation in case I was missing something that x86 is not affected.
> I will apply the first 2 patches, no need to resubmit.
> 
Ok, great. The commit comment might need tweaking for the first
patch now that the x86 code remains unchanged.

Cheers,

Will
