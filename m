From: balbi@ti.com (Felipe Balbi)
Date: Thu, 13 Sep 2012 08:01:37 +0300
Subject: [PATCH v4 00/21] OMAP UART Patches
In-Reply-To: <alpine.DEB.2.00.1209122025020.17903@utopia.booyaka.com>
References: <20120906122948.GC29202@arwen.pp.htv.fi>
 <1346935540-1792-1-git-send-email-balbi@ti.com>
 <alpine.DEB.2.00.1209062137000.11516@utopia.booyaka.com>
 <alpine.DEB.2.00.1209112141220.9444@utopia.booyaka.com>
 <20120912062259.GC18563@arwen.pp.htv.fi>
 <alpine.DEB.2.00.1209122025020.17903@utopia.booyaka.com>
Message-ID: <20120913050136.GA6504@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 12, 2012 at 08:25:30PM +0000, Paul Walmsley wrote:
> Hi
> 
> On Wed, 12 Sep 2012, Felipe Balbi wrote:
> 
> > On Tue, Sep 11, 2012 at 10:02:48PM +0000, Paul Walmsley wrote:
> > 
> > > The bad news is that N800 no longer boots -- or the UART dies during 
> > > serial init:
> > > 
> > > http://www.pwsan.com/omap/testlogs/test_tty_next_e36851d0/20120910020323/boot/2420n800/2420n800_log.txt
> > > 
> > > The problem doesn't seem to affect the 2430SDP.
> > > 
> > > Could you put together a patch to fix N800?
> > 
> > I'll see what I can do. BTW, is that log with DEBUG_LL enabled ?
> 
> Yes.  Here's the .config that was used on N800:
> 
> http://www.pwsan.com/omap/testlogs/test_tty_next_e36851d0/20120910020323/build/n800_b_testconfig/Kconfig

Thanks :-)

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120913/8255a1cf/attachment.sig>
