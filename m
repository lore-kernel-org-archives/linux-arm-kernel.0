From: horms@verge.net.au (Simon Horman)
Date: Sat, 8 Sep 2012 09:10:26 +0900
Subject: [GIT PULL] Renesas ARM-based SoC: SoC for 3.7
In-Reply-To: <20120907214951.GA2766@quad.lixom.net>
References: <1346896928-5750-1-git-send-email-horms@verge.net.au>
 <20120907214951.GA2766@quad.lixom.net>
Message-ID: <20120908001024.GA28510@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 07, 2012 at 02:49:51PM -0700, Olof Johansson wrote:
> Hi,
> 
> On Thu, Sep 06, 2012 at 11:02:07AM +0900, Simon Horman wrote:
> > Hi Olof, Hi Arnd,
> > 
> > please consider the following SoC enhancement from
> > Phil Edworthy for inclusion in 3.7.
> > 
> > ----------------------------------------------------------------
> > The following changes since commit 7952717adb69efc1d2443a1858f96d23c2fb93e0:
> > 
> >   ARM: shmobile: kzm9g: enable restarting (2012-08-25 14:39:44 +0900)
> > 
> > are available in the git repository at:
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git soc
> 
> The above is based on the previous branch we pulled from you (kzm9g), and
> contains a patch to support rebooting of a board. I would have expected that to
> be the base for your board branch but not the SoC branch.
> 
> Did you mean to base them like this for some other reason that I didn't
> realize, or would you mind switching the two branches so that the board
> one includes the restart change but not the other way around?

Sorry about that, I'll switch things around.
