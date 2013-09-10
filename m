From: neilb@suse.de (NeilBrown)
Date: Tue, 10 Sep 2013 10:04:21 +1000
Subject: [GIT PULL 0/3] ARM: SoC: Second round of changes for v3.12
In-Reply-To: <CA+55aFxNbH+G6DVQNxE9di_btA5hxFH93af_vjN2v0eH8e5W-g@mail.gmail.com>
References: <1378766555-9679-1-git-send-email-khilman@linaro.org>
 <CA+55aFxNbH+G6DVQNxE9di_btA5hxFH93af_vjN2v0eH8e5W-g@mail.gmail.com>
Message-ID: <20130910100421.5c481df0@notabene.brown>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 9 Sep 2013 16:49:23 -0700 Linus Torvalds
<torvalds@linux-foundation.org> wrote:

> On Mon, Sep 9, 2013 at 3:42 PM, Kevin Hilman <khilman@linaro.org> wrote:
> >
> > The main thing of note (or of potential annoyance factor) here is the
> > handful of conflicts in PULL 2/3 coming from platform changes
> > conflicting with driver changes going in to the V4L tree.  I've listed
> > them in detail in that pull request, and we will work with the
> > platform maintainer on the workflow to avoid this in the future.
> 
> Ok. I still really despise the absolute incredible sh*t that is
> non-discoverable buses, and I hope that ARM SoC hardware designers all
> die in some incredibly painful accident.  DT only does so much.
> 
> So if you see any, send them my love, and possibly puncture the
> brake-lines on their car and put a little surprise in their coffee,
> ok?

As you wish.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 828 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130910/a4eeff4c/attachment-0001.sig>
