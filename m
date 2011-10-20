From: msalter@redhat.com (Mark Salter)
Date: Thu, 20 Oct 2011 09:02:57 -0400
Subject: [PATCH] arm: fix handling of nr_cpus
In-Reply-To: <20111020112552.GY21648@n2100.arm.linux.org.uk>
References: <1318339864-32396-1-git-send-email-msalter@redhat.com>
	<20111012172628.GC21648@n2100.arm.linux.org.uk>
	<1318508268.2300.67.camel@deneb.redhat.com>
	<20111013151004.GF21648@n2100.arm.linux.org.uk>
	<1318943804.2346.15.camel@deneb.redhat.com>
	<20111020112552.GY21648@n2100.arm.linux.org.uk>
Message-ID: <1319115778.14825.17.camel@deneb.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2011-10-20 at 12:25 +0100, Russell King - ARM Linux wrote:
> On Tue, Oct 18, 2011 at 09:16:43AM -0400, Mark Salter wrote:
> > That's fine by me. mach-msm, mach-shmobile, and mach-vexpress also need
> > patching. They currently don't clip against NR_CPUS.
> 
> So more like this then?

Yes. That works for me.

--Mark
