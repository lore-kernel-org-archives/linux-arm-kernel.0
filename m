From: swarren@nvidia.com (Stephen Warren)
Date: Tue, 14 Feb 2012 14:38:16 -0800
Subject: [PATCH] Optimize multi-CPU tlb flushing a little more
In-Reply-To: <20120214222354.GB29765@n2100.arm.linux.org.uk>
References: <20110823110602.GG19622@n2100.arm.linux.org.uk>
 <CAH+eYFC_mkdObV0NfN5Jtv0L6fM9e0YGOBghTEVSqf=TAFxdXw@mail.gmail.com>
 <20120213162359.GC25655@n2100.arm.linux.org.uk>
 <20120213165926.GA24426@debian>
 <74CDBE0F657A3D45AFBB94109FB122FF178FACB6A1@HQMAIL01.nvidia.com>
 <20120214222354.GB29765@n2100.arm.linux.org.uk>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF178FACB6D7@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King wrote at Tuesday, February 14, 2012 3:24 PM:
> On Tue, Feb 14, 2012 at 01:59:34PM -0800, Stephen Warren wrote:
> > Aha, I should have searched harder for my stack trace... This thread
> > describes the exact problem I just posted about a couple of hours ago,
> > and Russell's suggested fix solves my problem.
> 
> Here's a better fix:
> ...

Tested-by: Stephen Warren <swarren@nvidia.com>

-- 
nvpublic
