From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 6 May 2014 09:32:17 -0400
Subject: [PATCHv3 5/5] ARM: configs: add ahci_mvebu to multi_v7_defconfig
In-Reply-To: <20140505215121.GG29245@quad.lixom.net>
References: <1397574006-5868-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1397574006-5868-6-git-send-email-thomas.petazzoni@free-electrons.com>
 <20140426002518.GL28159@titan.lakedaemon.net>
 <20140505215121.GG29245@quad.lixom.net>
Message-ID: <20140506133217.GT28159@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 05, 2014 at 02:51:21PM -0700, Olof Johansson wrote:
> On Fri, Apr 25, 2014 at 08:25:18PM -0400, Jason Cooper wrote:
> > Arnd, Olof, Kevin,
> > 
> > On Tue, Apr 15, 2014 at 05:00:06PM +0200, Thomas Petazzoni wrote:
> > > The Marvell Armada 38x platform needs the ahci_mvebu driver enabled
> > > for the AHCI interfaces, so this commit enables the corresponding
> > > Kconfig option in multi_v7_defconfig.
> > > 
> > > Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> > > ---
> > >  arch/arm/configs/multi_v7_defconfig | 1 +
> > >  1 file changed, 1 insertion(+)
> > 
> > Conflict-ridden file, please take directly.
> > 
> > Acked-by: Jason Cooper <jason@lakedaemon.net>
> 
> Just like many other maintainers, just getting added on cc on the ack doesn't
> fit our work flows very well.

gah, yes of course.  I was being lazy.  I'll bounce or resend in the
future.

thx,

Jason.
