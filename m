From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Wed, 16 May 2012 12:40:17 +0300
Subject: [PATCH v7 3/3] MTD: atmel_nand: Update driver to support
 Programmable Multibit ECC controller
In-Reply-To: <20403.29677.517067.528042@ipc1.ka-ro>
References: <1337093256-19117-1-git-send-email-josh.wu@atmel.com>
 <1337093256-19117-4-git-send-email-josh.wu@atmel.com>
 <1337160353.24809.26.camel@sauron.fi.intel.com>
 <20403.29677.517067.528042@ipc1.ka-ro>
Message-ID: <1337161217.24809.38.camel@sauron.fi.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2012-05-16 at 11:31 +0200, Lothar Wa?mann wrote:
> > > +		dev_warn(host->dev, "Only 2048 page size is currently " \
> > > +			"supported for PMECC, rolling back to Software ECC\n");
> > 
> > Why do you use backslashes?
> > 
> message text should not be split across lines anyway to ease grepping
> for the message.

I think the consensus is that it is personal decision of the author. I
am not trying to enforce this and I also split messages. In this case I
was only wondering why that backslash is used? I never saw this before
in the linux kernel.

-- 
Best Regards,
Artem Bityutskiy
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120516/ffb6af6a/attachment.sig>
