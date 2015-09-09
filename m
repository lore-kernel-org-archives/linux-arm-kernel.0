From: scottwood@freescale.com (Scott Wood)
Date: Wed, 9 Sep 2015 11:41:03 -0500
Subject: [PATCH v2 06/10] clk: qoriq: Add ls2080a support.
In-Reply-To: <CADRPPNRhBObf4Am-MKFHFk6y+_PmtZGuGrfVaDPtra6h394Fog@mail.gmail.com>
References: <1441349872-4560-1-git-send-email-bhupesh.sharma@freescale.com>
 <1441349872-4560-7-git-send-email-bhupesh.sharma@freescale.com>
 <CADRPPNQsemXa2HgYZAcm+GurhimHbYVM5CL5ReDsyuzfAO=kSQ@mail.gmail.com>
 <BY1PR0301MB1303A3BD91F3E65853CC3F2E82570@BY1PR0301MB1303.namprd03.prod.outlook.com>
 <CADRPPNRhBObf4Am-MKFHFk6y+_PmtZGuGrfVaDPtra6h394Fog@mail.gmail.com>
Message-ID: <1441816863.29081.11.camel@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2015-09-04 at 16:06 -0500, Li Yang wrote:
> On Fri, Sep 4, 2015 at 3:09 PM, Sharma Bhupesh
> <bhupesh.sharma@freescale.com> wrote:
> > > From:  pku.leo at gmail.com[mailto:pku.leo at gmail.com]
> > > Sent: Saturday, September 05, 2015 1:32 AM
> > > On Fri, Sep 4, 2015 at 1:57 AM, Bhupesh Sharma
> > > <bhupesh.sharma@freescale.com> wrote:
> > > > From: Scott Wood <scottwood@freescale.com>
> > > > 
> > > > LS2080A is the first implementation of the chassis 3 clockgen, which
> > > > has a different register layout than previous chips.  It is also
> > > > little endian, unlike previous chips.
> > > > 
> > > > Signed-off-by: Scott Wood <scottwood@freescale.com>
> > > > ---
> > > 
> > > You should probably mention here that the patch is depending on another
> > > pending patch to apply.  And this patch should be going through the same
> > > sub-system tree as the dependency patch.  Otherwise, there is no way it
> > > can be applied.
> > > 
> > 
> > Cover-letter already captures this:
> > http://www.spinics.net/lists/arm-kernel/msg442910.html
> > 
> > See the section 'Rebasing details'. linux-clk is already copied.
> 
> But not all the patches are depending on the clk patches.  You should
> probably break up the series to patches that can be applied cleanly
> and patches that are depending on the clock patches and should go
> through the clk tree.

The clock patches have already been acked, so they don't necessarily need to 
go via the clock tree.  However, there are both ARM and PPC patches that 
depend on them, so maybe we should create a topic branch?

-Scott
