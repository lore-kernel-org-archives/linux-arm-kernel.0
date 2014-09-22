From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Tue, 23 Sep 2014 00:46:24 +0200
Subject: [PATCH v4 18/18] Documentation: ACPI for ARM64
In-Reply-To: <20140922203136.GA32156@srcf.ucam.org>
References: <1410530416-30200-1-git-send-email-hanjun.guo@linaro.org>
 <20140922194841.GA9868@amd> <20140922203136.GA32156@srcf.ucam.org>
Message-ID: <2486199.jzqMgLksH8@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, September 22, 2014 09:31:36 PM Matthew Garrett wrote:
> On Mon, Sep 22, 2014 at 09:48:41PM +0200, Pavel Machek wrote:
> > On Fri 2014-09-12 22:00:16, Hanjun Guo wrote:
> > > +No code shall be accepted into the kernel unless it complies with the released
> > > +standards from UEFI ASWG. If there are features missing from ACPI to make it
> > > +function on a platform, ECRs should be submitted to ASWG and go through the
> > > +approval process.
> > 
> > Surely this should be narrowed down somehow? Or is reading all the
> > released standards from ASWG mandatory before patching the kernel now?
> > 
> > Spelling out wtf ECR is would be nice, too.
> 
> Explicit Change Request. These can only be filed by paid-up members of 
> the UEFI Forum, so I suspect this requirement is going to be unworkable 
> (there's plenty of ACPI support code for large x86 vendors which isn't 
> part of any ACPI spec).

Why do you think so?

Linux Foundation can do that on behalf of the community if no one else.

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
