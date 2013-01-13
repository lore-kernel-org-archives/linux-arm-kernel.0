From: vinod.koul@intel.com (Vinod Koul)
Date: Sun, 13 Jan 2013 05:25:44 -0800
Subject: [PATCH v4 2/7] pl080.h: moved from arm/include/asm/hardware to
 include/linux/amba/
In-Reply-To: <20121210222516.GA31546@mail.gnudd.com>
References: <1355146956-6009-1-git-send-email-ciminaghi@gnudd.com>
 <1355146956-6009-3-git-send-email-ciminaghi@gnudd.com>
 <CACRpkdbF6S6nOQFwv+tmS4LXhnnwkQxzmGYmH3Xn6TM4E34r8g@mail.gmail.com>
 <20121210222516.GA31546@mail.gnudd.com>
Message-ID: <20130113132544.GZ19691@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 10, 2012 at 11:25:17PM +0100, Davide Ciminaghi wrote:
> On Mon, Dec 10, 2012 at 10:44:09PM +0100, Linus Walleij wrote:
> > On Mon, Dec 10, 2012 at 2:42 PM, Davide Ciminaghi <ciminaghi@gnudd.com> wrote:
> > 
> > > From: Alessandro Rubini <rubini@gnudd.com>
> > >
> > > The header is used by drivers/dma/amba-pl08x.c, which can be compiled
> > > under x86, where PL080 exists under a PCI-to-AMBA bridge. This patche
> > > moves it where it can be accessed by other architectures, and fixes
> > > all users.

Applied, Thanks

--
~Vinod
