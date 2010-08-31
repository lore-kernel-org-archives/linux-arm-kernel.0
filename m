From: robert.richter@amd.com (Robert Richter)
Date: Tue, 31 Aug 2010 12:30:01 +0200
Subject: [PATCH] oprofile, x86: fix init_sysfs error handling
In-Reply-To: <1283247089.4063.2.camel@e102144-lin.cambridge.arm.com>
References: <1283107921-21464-1-git-send-email-will.deacon@arm.com>
	<1283107921-21464-2-git-send-email-will.deacon@arm.com>
	<1283107921-21464-3-git-send-email-will.deacon@arm.com>
	<1283107921-21464-4-git-send-email-will.deacon@arm.com>
	<20100830090929.GU22783@erda.amd.com>
	<1283244880.645.17.camel@e102144-lin.cambridge.arm.com>
	<20100831090518.GZ22783@erda.amd.com>
	<1283247089.4063.2.camel@e102144-lin.cambridge.arm.com>
Message-ID: <20100831103001.GC22783@erda.amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 31.08.10 05:31:29, Will Deacon wrote:
> > For x86 wont change the code (actually I found a bug in the init_sysfs
> > error handler for which I will send a fix). Just wanted to get your
> > confirmation in case I was missing something that x86 is not affected.
> > I will apply the first 2 patches, no need to resubmit.

This is the patch, applied to:

 git://git.kernel.org/pub/scm/linux/kernel/git/rric/oprofile.git urgent

-Robert

--
