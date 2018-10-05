From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 5 Oct 2018 17:43:03 +0200
Subject: [GIT PULL] Allwinner H3/H5 changes for 4.20, bis
In-Reply-To: <20181004193630.lbxyiecochf5cdfq@flea>
References: <20181004193630.lbxyiecochf5cdfq@flea>
Message-ID: <CAK8P3a121EMnah1rKx7H8Bu1MrH_ZLyq3kNMM3U6eo13Gpx6yg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 4, 2018 at 9:36 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> Hi Arnd, Olof,
>
> Here is a second attempt at the previous PR for the H3 and H5 changes,
> hopefully with the right SoB this time. It replaces the previous one.

Hi Maxime,

I'm not completely sure about this, we generally try not to rebase the
branches, and the previous version is now deep in the git history of the
next/dt branch.

Obviously having a missing signoff is also bad, but I think keeping
the old version of your branch is better in this case. Merging the
new branch on top of next/dt would give us a proper signoff chain on
each patch, but would not remove the patches with the missing
signoff. Instead we'd have lots of duplicate commits, which is probably
worse.

Olof, do you have any other ideas?

       Arnd
