From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 4 Feb 2013 07:05:14 -0500
Subject: [GIT PULL  0/4] ARM: mvebu: changes for v3.9
In-Reply-To: <510F7156.70005@free-electrons.com>
References: <1359733918.Bf7ecc0.22262@triton>
 <510F7156.70005@free-electrons.com>
Message-ID: <20130204120514.GK14746@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 04, 2013 at 09:29:10AM +0100, Gregory CLEMENT wrote:
> Hi Jason,
> 
> On 02/01/2013 04:51 PM, Jason Cooper wrote:
> > The following changes since commit 19d23dac1b8f95e4a960fcbbb5687c33b9a2cd01:
> > 
> >   Merge branch 'fixes' into for-next
> > 
> > are available in the git repository at:
> > 
> >   git://git.infradead.org/users/jcooper/linux.git mvebu/for-next
> > 
> > for you to fetch changes up to 7d8a7dce24f76242daf1c469878597b8acc4f78f:
> > 
> >   Merge tag 'tags/dt_for_v3.9' into mvebu/for-next
> > 
> > Jason Cooper (5):
> >       Merge tag 'tags/mvebu_fixes_for_v3.8-rc6' into mvebu/for-next
> >       Merge tag 'tags/cleanup_for_v3.9_round2' into mvebu/for-next
> >       Merge tag 'tags/drivers_for_v3.9' into mvebu/for-next
> >       Merge tag 'tags/boards_for_v3.9' into mvebu/for-next
> >       Merge tag 'tags/dt_for_v3.9' into mvebu/for-next
> 
> I didn't see anything about the USB support for Armada370/XP sent
> by Ezequiel. Is there any reason to not have it? Or do you plan
> to send a new pull request soon with his patch set?

Yes, this is a redo of the first series of requests I sent out.  I had
to move mvsdio out to the appropriate maintainer tree and depend on it.
As soon as this gets pulled in, I have another round with everything but
Thomas' pci work.  His will most likely be a separate pr series.

> PS: I noticed that there are a some files not related to mvebu at all
> (such as the arch/parisc/... for example), but I guess it is due to some
> dependencies.

Yeah, I'm working on that.  It's purely in the diffstat, so it's not a
show stopper.  It's much cleaner than the first time around, which is an
improvement.

thx,

Jason.
