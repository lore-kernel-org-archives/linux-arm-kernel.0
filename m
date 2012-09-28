From: jdl@jdl.com (Jon Loeliger)
Date: Fri, 28 Sep 2012 13:53:33 -0500
Subject: [PATCH 1/1] Fix segfault in DTC
In-Reply-To: <5065D9C7.40906@wwwdotorg.org>
References: <1348526885-2113-1-git-send-email-mmayer@broadcom.com>
 <1348595889-6495-1-git-send-email-mmayer@broadcom.com>
 <1348595889-6495-2-git-send-email-mmayer@broadcom.com>
 <20120925233054.GL9800@truffula.fritz.box> <50624393.30607@broadcom.com>
 <20120926003508.GB31993@truffula.fritz.box> <50632F78.4030709@broadcom.com>
 <5065D9C7.40906@wwwdotorg.org>
Message-ID: <E1THfgr-0006Fg-KT@jdl.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > 
> > Yeah, seems like the kernel DTC is quite old.
> 
> FYI, I'm working on a patch to the kernel to bring in the latest dtc.

Awesome.  Thank you.

> I've run a regression test vs. the old dtc in the kernel ...

Which is the icky step.  Again, thank you.

> ... and found that
> some of the PowerPC .dts files don't compile with the new dtc (but did
> with the old), all due to non-existent labels/paths being referenced.
> I'll try and track down whether this is a regression in dtc, or simply
> buggy .dts files that weren't noticed before.

I think you should just smack the PowerPC guys. :-)

> Everything non-PowerPC works fine, and most PowerPC files work fine.
> Where compilation succeeds, the md5sum of the .dtb is identical in every
> case.

Cool.

Thanks,
jdl
