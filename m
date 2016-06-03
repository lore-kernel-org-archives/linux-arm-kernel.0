From: kraxel@redhat.com (Gerd Hoffmann)
Date: Fri, 03 Jun 2016 10:50:16 +0200
Subject: [PATCH v2 5/9] arm64: Add BCM2835 support to the defconfig.
In-Reply-To: <3299125.qWct7BqQgQ@wuerfel>
References: <1464934708-24769-1-git-send-email-kraxel@redhat.com>
 <1464934708-24769-6-git-send-email-kraxel@redhat.com>
 <3299125.qWct7BqQgQ@wuerfel>
Message-ID: <1464943816.24775.135.camel@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fr, 2016-06-03 at 09:36 +0200, Arnd Bergmann wrote:
> On Friday, June 3, 2016 8:18:24 AM CEST Gerd Hoffmann wrote:
> > From: Eric Anholt <eric@anholt.net>
> > 
> > Made with make defconfig; make menuconfig (only saying Y to new
> > entries); make savedefconfig.
> 
> Please try not to mix 'make savedefconfig' changes with your
> own changes, it make it harder to review and can lead to more
> conflicts.

This is just conflicts resolved by hand after 4.6 -> 4.7-rc1 rebase,
latest version didn't actually ran through savedefconfig.  Probably some
unwanted changes made it in by accident this way.

Guess I better redo this from scratch.

What is the suggested procedure to generate defconfig patches?

cheers,
  Gerd
