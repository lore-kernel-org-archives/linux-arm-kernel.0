From: balbi@ti.com (Felipe Balbi)
Date: Mon, 18 Feb 2013 12:11:13 +0200
Subject: [RFC/RFT PATCH 0/2] SERIAL: OMAP: Remove idle handling from driver
In-Reply-To: <20130218101032.GA32688@arwen.pp.htv.fi>
References: <1360929970-31934-1-git-send-email-santosh.shilimkar@ti.com>
 <5121FCC8.7090604@ti.com> <20130218101032.GA32688@arwen.pp.htv.fi>
Message-ID: <20130218101113.GB32688@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 18, 2013 at 12:10:32PM +0200, Felipe Balbi wrote:
> > HWMOD_SWSUP_SIDLE flag will is not what will help UART completely.
> > Also considering UART also needs async wakeup enabled as it implements
> > another such hook and attaches that through function pointer.
> 
> this is exactly what I said at [1], which I quote:
> 
> "Also, $SUBJECT isn't improving the situation regarding UART Wakeup,
> there is still the regression of UART never being wakeup capable.
> 
> I wonder what are your ideas to sort that part out, I mean, how do you
> plan to implement ->set_wake() for the tty port ?"

[1] http://marc.info/?l=linux-omap&m=136093334914275&w=2

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130218/bb90f34d/attachment.sig>
