From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Tue, 22 Aug 2017 20:38:05 +0200
Subject: [PATCH net-next v2 00/10] net: mvpp2: MAC/GoP configuration
In-Reply-To: <20170822180757.GD18076@lunn.ch>
References: <20170822170830.32413-1-antoine.tenart@free-electrons.com>
 <20170822180757.GD18076@lunn.ch>
Message-ID: <20170822183805.GD14942@kwain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew,

On Tue, Aug 22, 2017 at 08:07:57PM +0200, Andrew Lunn wrote:
> On Tue, Aug 22, 2017 at 07:08:20PM +0200, Antoine Tenart wrote:
> > 
> > This is based on net-next (e2a7c34fb285).
> > 
> > I removed the GoP interrupt and PHY optional parts in this v2 to ease
> > the review process as the MAC/GoP initialization seemed to start less
> > discussions :)
> 
> By that, do you mean setting the SMI PHY address?

Yes, the one set in the GoP. You asked more precisions but I need get
more info to answer, so I removed it in the meantime.

Antoine

-- 
Antoine T?nart, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170822/8cf7ddf6/attachment.sig>
