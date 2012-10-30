From: balbi@ti.com (Felipe Balbi)
Date: Tue, 30 Oct 2012 14:32:54 +0200
Subject: OMAP baseline test results for v3.7-rc1
In-Reply-To: <alpine.DEB.2.00.1210301216330.12697@utopia.booyaka.com>
References: <alpine.DEB.2.00.1210200611150.9865@utopia.booyaka.com>
 <CAORVsuUkU3iTTFcXfYJ=_FntjiTR33Gs4z9OsNEn2Cxq7Ef-qA@mail.gmail.com>
 <CAORVsuWFzH3UmXCaY=iqmYsE72KOecLo40tG9BcTUBirJQ5iLA@mail.gmail.com>
 <alpine.DEB.2.00.1210231918500.27211@utopia.booyaka.com>
 <CAORVsuV9_4oc6+voEM9PkqzkXKHipor5XJqaXfDNxAWLofXcxg@mail.gmail.com>
 <20121025101212.GD21217@arwen.pp.htv.fi>
 <20121026201539.GD29548@arwen.pp.htv.fi>
 <alpine.DEB.2.00.1210262201500.11258@utopia.booyaka.com>
 <20121029200032.GD30152@arwen.pp.htv.fi>
 <alpine.DEB.2.00.1210301216330.12697@utopia.booyaka.com>
Message-ID: <20121030123254.GD29095@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Oct 30, 2012 at 12:17:11PM +0000, Paul Walmsley wrote:
> On Mon, 29 Oct 2012, Felipe Balbi wrote:
> 
> > that's too bad :-(
> > 
> > Can you compile with:
> > 
> > CONFIG_I2C_DEBUG_CORE=y
> > CONFIG_I2C_DEBUG_ALGO=y
> > CONFIG_I2C_DEBUG_BUS=y
> > CONFIG_DEFAULT_MESSAGE_LOGLEVEL=9
> > 
> > so that I can see all transfers ?
> 
> Log is below.

that's working. It only helps to let me know we have a race somewhere,
and if it is what I'm thinking, the wmb() patch should help, but you
said it doesn't, right ?

without seeing debugging information on the failing case, it'll be very
difficult to sort this one out provided noone else seems to be able to
reproduce it.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121030/7cf1545c/attachment.sig>
