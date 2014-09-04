From: broonie@kernel.org (Mark Brown)
Date: Thu, 4 Sep 2014 18:06:30 +0100
Subject: [PATCH 1/2] gpio: Add driver for AXM55xx SSP chip selects
In-Reply-To: <CACRpkdby4H-fivNn_kG2uL0EjsCGAc+t6OyFi0+VcNGf2Z9NQA@mail.gmail.com>
References: <1409576021-24828-1-git-send-email-anders.berg@avagotech.com>
 <1409576021-24828-2-git-send-email-anders.berg@avagotech.com>
 <CACRpkdby4H-fivNn_kG2uL0EjsCGAc+t6OyFi0+VcNGf2Z9NQA@mail.gmail.com>
Message-ID: <20140904170630.GL29327@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 04, 2014 at 07:04:44PM +0200, Linus Walleij wrote:
> I need an ACK from Mark Brown on this before I apply.
> The driver seems to do what it should, but I need Mark to
> be OK with exporting the CS signals from an SSP/SPI block
> to be exposed to Linux as GPIOs.
> 
> (Top-posting and quoting patch verbatim so Mark gets it.)

I don't see any sort of reasoning for this?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140904/bda0080d/attachment.sig>
