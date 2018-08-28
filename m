From: pavel@ucw.cz (Pavel Machek)
Date: Wed, 29 Aug 2018 00:41:58 +0200
Subject: 4.19-rc1 on droid 4: screen not updating
In-Reply-To: <20180828023722.GK7523@atomide.com>
References: <20180827105121.GA8283@amd>
 <20180828023722.GK7523@atomide.com>
Message-ID: <20180828224158.GA12978@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> > With Sebastian's patches, display works on Droid 4 in v4.18.
> 
> Hmm care to post your v4.18 patches somewhere too for people?
> I'd have to look around for them since I've been using Linux
> next for past few months.

I don't have patches separated at the moment. I pushed the branch to

git at gitolite.kernel.org:pub/scm/linux/kernel/git/pavel/linux-n900.git

all-v4.18

> Also, do you have v4.19-rc1 versions of your pending audio
> patches somewhere? I'd like to play with voice calls again
> now with my WIP pending n_gsm serdev patches..

I pushed that to all-v4.19 .

> > I had to do some manual merging, and I see kernel messages in
> > v4.19-rc1, but they are frozen -- no updates.
> > 
> > a) does someone have it working?
> 
> I have had it working for few weeks since I'm following
> Linux next. I just pushed Sebastian's patches I rebased
> earlier today against v4.19-rc1 to [0][1].

Thanks, will take a look tommorow.

> > b) is there some way I can help to get it working in mainline? Droid 4
> > is not exactly new, and this is painful point that makes it hard to
> > use.
> 
> Well since Sebastian is busy according to [2], maybe try to update
> Sebastian's mfd-ti-lmu backlight patches so they can get merged?
> Please check with Sebastian, but that would cut down the pending
> pile by quite a few patches.

Ok, let me take a look.

I currently don't have the patches separated, and yes, the audio ones
work, but no, they are not designed right :-(. 

Best regards,
									Pavel

> [0] git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap droid4-pending-v4.19
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap.git/log/?h=droid4-pending-v4.19
> [2] https://lists.freedesktop.org/archives/dri-devel/2018-August/186226.html

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180829/9e19c2df/attachment.sig>
