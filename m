From: soren.brinkmann@xilinx.com (Soren Brinkmann)
Date: Tue, 18 Dec 2012 20:23:32 -0800
Subject: [PATCH 0/7] Updates for Zynq's timer driver
In-Reply-To: <20121219025945.GF27963@beefymiracle.amer.corp.natinst.com>
References: <bfaf054c-2b45-458e-a67f-f9d1c982ec51@TX2EHSMHS017.ehs.local>
 <20121219025945.GF27963@beefymiracle.amer.corp.natinst.com>
Message-ID: <32732a9b-d3a7-498f-a3d0-9f0c4f0bf8b2@CO9EHSMHS032.ehs.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Josh,

On Tue, Dec 18, 2012 at 08:59:45PM -0600, Josh Cartwright wrote:
> On Tue, Dec 18, 2012 at 04:16:32PM -0800, Soren Brinkmann wrote:
> > I started to put some effort on syncing the Xilinx Linux tree with mainline and
> > the timer driver is my first victim.
> > Most commits are fixing style issues or clean up. Functionality is touched only
> > in patches #2 and #7.
> > 
> > Some patches are present in almost identically in the Xilinx Linux tree and I
> > took over 'Ackec-by' lines from those commits.
> > 
> > 	Soren
> > 
> > Soren Brinkmann (7):
> >   arm: zynq: timer: Replace PSS through PS
> >   arm: zynq: timer: Remove unnecessary register write
> >   arm: zynq: timer: Remove unused #defines
> >   arm: zynq: timer: Align columns
> >   arm: zynq: timer: Remove redundant #includes
> >   arm: zynq: timer: Fix comment style
> >   arm: zynq: timer: Set clock_event cpumask
> 
> Hey Soren-
> 
> I had a look through this patchset and besides the stylistic nit in
> patch 1, everything looks good to me.  Feel free to add my Reviewed-by.
> 
> Also, you seem to have neglected linux-arm-kernel from CC, you'll likely
> want to repost there.
Thanks, for reviewing and the heads up. I'll add the reviewed-by lines and
repost including linux-arm-kernel.

	Soren
