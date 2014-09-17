From: mjg59@srcf.ucam.org (Matthew Garrett)
Date: Wed, 17 Sep 2014 02:57:34 +0100
Subject: [PATCH v4 18/18] Documentation: ACPI for ARM64
In-Reply-To: <20140917014410.GC31214@srcf.ucam.org>
References: <1410530416-30200-1-git-send-email-hanjun.guo@linaro.org>
 <1410530416-30200-19-git-send-email-hanjun.guo@linaro.org>
 <20140917014410.GC31214@srcf.ucam.org>
Message-ID: <20140917015734.GD31214@srcf.ucam.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 17, 2014 at 02:44:10AM +0100, Matthew Garrett wrote:
> On Fri, Sep 12, 2014 at 10:00:16PM +0800, Hanjun Guo wrote:
> > +No code shall be accepted into the kernel unless it complies with the released
> > +standards from UEFI ASWG. If there are features missing from ACPI to make it
> > +function on a platform, ECRs should be submitted to ASWG and go through the
> > +approval process.
> 
> Similar question here. Is the expectation that all ARM vendors will 
> become UEFI contributors?

I should also add that this is inconsistent with how we've managed 
things in the x86 world - there's a great deal of ACPI functionality 
implemented that's not covered in the spec.

-- 
Matthew Garrett | mjg59 at srcf.ucam.org
