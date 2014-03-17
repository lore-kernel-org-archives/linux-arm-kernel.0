From: olof@lixom.net (Olof Johansson)
Date: Sun, 16 Mar 2014 21:44:53 -0700
Subject: [GIT PULL v2] Xilinx Zynq changes for v3.15
In-Reply-To: <53204D22.2000703@monstr.eu>
References: <53061EBA.1080002@monstr.eu> <531D746A.4020903@monstr.eu>
 <20140311213331.GA6429@quad.lixom.net> <53204D22.2000703@monstr.eu>
Message-ID: <20140317044453.GA18210@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 12, 2014 at 01:03:46PM +0100, Michal Simek wrote:
> On 03/11/2014 10:33 PM, Olof Johansson wrote:
> > On Mon, Mar 10, 2014 at 09:14:34AM +0100, Michal Simek wrote:
> >> Hi,
> >>
> >> please pull these changes to your arm-soc tree. This branch is based
> >> on zynq/dt branch from the second pull request.
> >> I have kept OCM patch in this branch because it depends on slcr changes
> >> done here. If you want to send another pull request just for this OCM
> >> patch based on this branch, please let me know.
> >>
> >> Changes in v2: Fix incorrect git repo url
> > 
> > Thanks!
> > 
> >> The following changes since commit 3795e91d2abb25164dda5687ca680a7ab940c447:
> >>
> >>   arm: dt: zynq: Add fclk-enable property to clkc node (2014-02-03 17:00:24 +0100)
> >>
> >> are available in the git repository at:
> >>
> >>   git://git.xilinx.com/linux-xlnx.git tags/zynq-cleanup-for-3.15
> >>
> >> for you to fetch changes up to e9aa3e3a5bb2d64515648537100e5cf9b863e01a:
> >>
> >>   ARM: zynq: Add support for SOC_BUS (2014-02-20 16:08:47 +0100)
> >>
> >> ----------------------------------------------------------------
> >> arm: Xilinx Zynq cleanup patches for v3.15
> >>
> >> - Redesign SLCR initialization to enable
> >>   driver developing which targets SLCR space
> >> - Add OCM driver
> >> - Add SOC_BUS support
> >>
> >> ----------------------------------------------------------------
> >> Michal Simek (8):
> >>       ARM: zynq: Split slcr in two parts
> >>       ARM: zynq: Map I/O memory on clkc init
> >>       ARM: zynq: Add and use zynq_slcr_read/write() helper functions
> >>       ARM: zynq: Introduce zynq_slcr_unlock()
> >>       ARM: zynq: Add OCM driver
> > 
> > Looking at the patches in the branch, this is the one I have most concern with.
> > I think it will require more work to get it in shape to get merged, as per
> > those comments.
> > 
> > I think it's worth to merge the other stuff though, so can you rebuild the
> > branch without the OCM driver so we can get the rest in for 3.15 even if the
> > OCM piece ends up taking longer?
> 
> No problem to do it. I will just wait one more day till we finish that discussions.
> Or is there any time pressure?

No time pressure from my side -- the releases roll on and the window for
getting stuff queued for 3.15 is closing, given that we might just have seen
the last -rc. I'll reply to the other thread.


-Olof
