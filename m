From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Fri, 5 Oct 2018 17:52:01 +0200
Subject: [GIT PULL] Allwinner H3/H5 changes for 4.20, bis
In-Reply-To: <CAK8P3a121EMnah1rKx7H8Bu1MrH_ZLyq3kNMM3U6eo13Gpx6yg@mail.gmail.com>
References: <20181004193630.lbxyiecochf5cdfq@flea>
 <CAK8P3a121EMnah1rKx7H8Bu1MrH_ZLyq3kNMM3U6eo13Gpx6yg@mail.gmail.com>
Message-ID: <20181005155201.que3qp6ljyd7f74m@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

On Fri, Oct 05, 2018 at 05:43:03PM +0200, Arnd Bergmann wrote:
> On Thu, Oct 4, 2018 at 9:36 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> >
> > Hi Arnd, Olof,
> >
> > Here is a second attempt at the previous PR for the H3 and H5 changes,
> > hopefully with the right SoB this time. It replaces the previous one.
> 
> I'm not completely sure about this, we generally try not to rebase the
> branches, and the previous version is now deep in the git history of the
> next/dt branch.
> 
> Obviously having a missing signoff is also bad, but I think keeping
> the old version of your branch is better in this case. Merging the
> new branch on top of next/dt would give us a proper signoff chain on
> each patch, but would not remove the patches with the missing
> signoff. Instead we'd have lots of duplicate commits, which is probably
> worse.

I definitely understand that. The issue went since Chen-Yu was the
initial committer, but due to last minute issues in some patches in
that branch, I rebased it to drop those patches and sent it.

So commits carrying Chen-Yu's SoB were now committed by me. I'm not
sure if it makes it better, but anyway... It's up to you, and sorry
for that mess :/

Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181005/30ded2a3/attachment.sig>
