From: dwalker@codeaurora.org (Daniel Walker)
Date: Mon, 03 May 2010 12:13:16 -0700
Subject: [GIT PULL] generic arm for MSM try 3
In-Reply-To: <20100503104431.GA29919@n2100.arm.linux.org.uk>
References: <1271787537.1986.10.camel@m0nster>
	<1272323880.32741.7.camel@c-dwalke-linux.qualcomm.com>
	<20100503104431.GA29919@n2100.arm.linux.org.uk>
Message-ID: <1272913996.16935.50.camel@c-dwalke-linux.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2010-05-03 at 11:44 +0100, Russell King - ARM Linux wrote:
> On Mon, Apr 26, 2010 at 04:18:00PM -0700, Daniel Walker wrote:
> > On Tue, 2010-04-20 at 11:18 -0700, Daniel Walker wrote:
> > > I dropped the copyright and rebased, but everything else is the same as
> > > the prior pull request.
> > > 
> > > The following changes since commit 27ee8963708185b96bc84a149eb5336a249a7497:
> > >   Linus Torvalds (1):
> > >         Merge branch 'urgent' of git://git.kernel.org/.../brodo/pcmcia-2.6
> > > 
> > > are available in the git repository at:
> > > 
> > >   git://codeaurora.org/quic/kernel/dwalker/linux-msm.git for-russell
> > 
> > Did I get this one wrong somehow, or are you not accepting pull requests
> > right now?
> 
> No.  In case you didn't notice, I've been offline from 22nd to 29th April
> caused by BT planned engineering works going wrong.  However, I'm back
> online for the time being using alternative arrangements, and I still
> regard my 'net connection to be 'at risk'.

Yeah, I noticed that after I sent this originally. It too bad about your
BT troubles. I hope that get squared away soon.

> Could you please tell me what is different in this pull request compared
> to try 2?  I'm asking because it appears your tree is identical to try 2,
> in spite of:
> 
> On Tue, Mar 30, 2010 at 03:59:53PM -0700, Daniel Walker wrote:
> > On Sun, 2010-03-28 at 22:49 +0100, Russell King - ARM Linux wrote:
> > > Well, I don't think it's fair on those who created abort-ev7.S to go
> > > throwing a boilerplate copyright on the file which makes it look like
> > > "Code Aurora Forum." wrote the entire thing.
> >
> > Ok, I updated the same branch .. It's minus the copyright and license ,
> > and I rebased it onto a more recent linus tree ..

Yes, I must have mistakenly dropped the "-f" from the push. I did
another rebase, and "push -f" just now. It should be as advertised
above. The same as the original pull requests only with out the
copyright.

Sorry for all the attempts ..

Daniel
