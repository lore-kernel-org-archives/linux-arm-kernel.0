From: broonie@kernel.org (Mark Brown)
Date: Wed, 17 Sep 2014 10:02:35 -0700
Subject: [PATCH v4 18/18] Documentation: ACPI for ARM64
In-Reply-To: <54194D22.7060706@redhat.com>
References: <1410530416-30200-1-git-send-email-hanjun.guo@linaro.org>
 <1410530416-30200-19-git-send-email-hanjun.guo@linaro.org>
 <20140917014410.GC31214@srcf.ucam.org>
 <54194D22.7060706@redhat.com>
Message-ID: <20140917170235.GP7960@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 17, 2014 at 04:58:10AM -0400, Jon Masters wrote:
> On 09/16/2014 09:44 PM, Matthew Garrett wrote:

> >> +http://www.uefi.org/sites/default/files/resources/_DSD-implementation-guide-toplevel.htm

> > How are individuals/companies who aren't UEFI members supposed to do 
> > this? Aren't there IP issues involved in taking submissions from 
> > non-members?

> Obviously, I'm not a lawyer, but I would note that the _DSD bindings
> aren't going into the core ACPI document. I think the specifics for non
> members of the UEFI to potentially contribute bindings need to be
> addressed. That said, at this point, the population of the UEFI forum is
> very well aligned with initial players (that this is the case is not
> entirely an accident, I went around to a few folks a year or so ago and
> made sure that they had become members in anticipation of this issue).

Are you sure you've covered all the vendors of off-SoC components who
might be involved?  That's certainly already an issue with people doing
x86 machines (who aren't being bound by this spec but as a subsystem
maintainer how am I supposed to tell if the target is an ARM or x86
system?).
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140917/82e0009b/attachment.sig>
