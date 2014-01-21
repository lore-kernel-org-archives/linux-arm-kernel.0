From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 21 Jan 2014 13:53:39 +0100
Subject: [PATCH v2 15/15] ARM: mvebu: Enable watchdog support in defconfig
In-Reply-To: <20140121124746.GZ29184@titan.lakedaemon.net>
References: <1390295561-3466-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1390295561-3466-16-git-send-email-ezequiel.garcia@free-electrons.com>
 <20140121124746.GZ29184@titan.lakedaemon.net>
Message-ID: <20140121125339.GH13396@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 21, 2014 at 07:47:46AM -0500, Jason Cooper wrote:
> On Tue, Jan 21, 2014 at 06:12:41AM -0300, Ezequiel Garcia wrote:
> > Now that we have proper support for Armada 370/XP watchdog
> > let's enable it in the defconfig.
> > 
> > Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> > ---
> >  arch/arm/configs/mvebu_defconfig | 2 ++
> >  1 file changed, 2 insertions(+)
> 
> Just a note to myself more than anything: I need to square up multi_v7
> with mvebu.  As we make these changes next cycle, we need to be able to
> easily test that we aren't breaking multiplat build or boot.

Hi Jason

Hopefully you can also tackle multi_v5 as well, once DT kirkwood moves
into mach-mvebu.

To check for breaking boot, you need some other hardware
platform. Nomadik was breaking kirkwood multi_v5, and you would not
see the problem on Nomadik.

    Andrew
