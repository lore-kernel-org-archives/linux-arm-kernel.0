From: olof@lixom.net (Olof Johansson)
Date: Tue, 11 Aug 2015 15:31:27 +0200
Subject: [GIT PULL] Nomadik improvements and cleanups for v4.3
In-Reply-To: <CACRpkdbN6ZDhH56PSUmPD5_uYJhk_o+mCqAvi5GVEtys=AftNg@mail.gmail.com>
References: <CACRpkdbN6ZDhH56PSUmPD5_uYJhk_o+mCqAvi5GVEtys=AftNg@mail.gmail.com>
Message-ID: <20150811133127.GN30181@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

On Thu, Aug 06, 2015 at 04:50:13PM +0200, Linus Walleij wrote:
> Hi ARM SoC folks,
> 
> these are a four patches of Nomadik cleanups and improvements
> targeted for v4.2.
> 
> Since there is a cross-dependency between the board files and the
> device tree files I just kept them all on the same branch. Also it seems
> a bit overzealous to split patches for this small platform.
> 
> Please pull it in as cleanup/development for v4.3.
> 
> Yours,
> Linus Walleij
> 
> The following changes since commit 74d33293e467df61de1b1d8b2fbe29e550dec33b:
> 
>   Linux 4.2-rc5 (2015-08-02 18:34:55 -0700)

This is 3 -rcs newer than we have our tree based on to date (-rc2).

I don't see any conflict with -rc2 though, so I've cherry-picked these over
instead of merging the branch.


Thanks!

-Olof
