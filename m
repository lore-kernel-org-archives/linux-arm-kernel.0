From: balbi@ti.com (Felipe Balbi)
Date: Tue, 21 Aug 2012 15:42:45 +0300
Subject: [PATCH 1/4] mfd: smsc: Add support for smsc gpio io/keypad driver
In-Reply-To: <20120821124146.GA21557@sirena.org.uk>
References: <1345545940-2232-1-git-send-email-sourav.poddar@ti.com>
 <1345545940-2232-2-git-send-email-sourav.poddar@ti.com>
 <20120821124146.GA21557@sirena.org.uk>
Message-ID: <20120821124243.GG10347@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 21, 2012 at 01:41:46PM +0100, Mark Brown wrote:
> > +	regmap_read(smsc->regmap, SMSC_DEV_ID, &ret);
> > +	dev_dbg(&i2c->dev, "SMSC Device ID: %d\n", ret);
> 
> I'd make these log messages dev_info() or something.

dev_info() ? It'lll just make boot noisier for no good reason. Which
user wants to see this during boot up ? That's a debugging feature for
develop IMHO.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120821/12e4dbf5/attachment.sig>
