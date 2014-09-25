From: will.deacon@arm.com (Will Deacon)
Date: Thu, 25 Sep 2014 10:04:06 +0100
Subject: [PATCH v12 09/12] OF: PCI: Add support for parsing PCI host
 bridge resources from DT
In-Reply-To: <20140925085432.GL1994@e106497-lin.cambridge.arm.com>
References: <1411498874-9864-1-git-send-email-Liviu.Dudau@arm.com>
 <1411498874-9864-10-git-send-email-Liviu.Dudau@arm.com>
 <20140924164304.GF1994@e106497-lin.cambridge.arm.com>
 <20140924173109.GA20416@google.com>
 <20140924175330.GI1994@e106497-lin.cambridge.arm.com>
 <20140924180119.GN16244@arm.com>
 <20140925085432.GL1994@e106497-lin.cambridge.arm.com>
Message-ID: <20140925090406.GD20043@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 25, 2014 at 09:54:32AM +0100, Liviu Dudau wrote:
> On Wed, Sep 24, 2014 at 07:01:19PM +0100, Will Deacon wrote:
> > On Wed, Sep 24, 2014 at 06:53:31PM +0100, Liviu Dudau wrote:
> > > Thanks again and sorry for lack of thorough testing. I still haven't managed
> > > to get a cross compiler for sparc and as I don't run Ubuntu or debian the
> > > make.cross script doesn't work for me.
> > 
> >   https://www.kernel.org/pub/tools/crosstool/
> > 
> > No libc, but good enough for building the kernel. I've asked for an aarch64
> > compiler there for a while, but it didn't materialise for some reason.
> 
> I'm familiar with crosstool and busybox uses a variant of crosstool-ng, but
> it currently fails with "configure: error: cannot compute suffix of object files: cannot compile"
> on the stage2 of the compilation.

Did you even follow the link? There are binary toolchains hosted there --
you don't have to build anything yourself if you don't want to.

Will
