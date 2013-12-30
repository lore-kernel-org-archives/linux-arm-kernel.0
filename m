From: broonie@kernel.org (Mark Brown)
Date: Mon, 30 Dec 2013 13:50:58 +0000
Subject: [PATCH v2 6/8] [RFC] Documentation: dt: Add Renesas RSPI/QSPI
 bindings
In-Reply-To: <CAMuHMdXYH6KmH3ZstAvhqUpqXWEbg6sjdUTDRZUrUthdPg-6aQ@mail.gmail.com>
References: <1388175362-17132-1-git-send-email-geert@linux-m68k.org>
 <1388175362-17132-7-git-send-email-geert@linux-m68k.org>
 <20131230125845.GX31886@sirena.org.uk>
 <CAMuHMdXYH6KmH3ZstAvhqUpqXWEbg6sjdUTDRZUrUthdPg-6aQ@mail.gmail.com>
Message-ID: <20131230135058.GD31886@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 30, 2013 at 02:43:53PM +0100, Geert Uytterhoeven wrote:
> On Mon, Dec 30, 2013 at 1:58 PM, Mark Brown <broonie@kernel.org> wrote:
> > On Fri, Dec 27, 2013 at 09:16:00PM +0100, Geert Uytterhoeven wrote:

> >> +- num-cs        : Number of chip selects

> > Why is this variable and how does this map onto hardware?

> It's my understanding that legacy RSPi on SH7757 has 2 chip selects,
> while other RSPI implementations have 1 chip select.

So this should be documented in the binding document in a way that
allows someone reading the document and looking at the datasheet to
figure out how to pick the value (for example, refer to how the chip
selects are controlled in the hardware).
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131230/c2481155/attachment.sig>
