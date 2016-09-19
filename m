From: broonie@kernel.org (Mark Brown)
Date: Mon, 19 Sep 2016 11:23:06 +0100
Subject: [PATCH] ASoC: samsung: make audio interface/controller explicitly
In-Reply-To: <1BBB8B7D-0C1B-48E0-A516-402515A04568@soulik.info>
References: <1474207751-9804-1-git-send-email-ayaka@soulik.info>
 <1474207751-9804-2-git-send-email-ayaka@soulik.info>
 <20160919083342.GE10189@sirena.org.uk>
 <1BBB8B7D-0C1B-48E0-A516-402515A04568@soulik.info>
Message-ID: <20160919102306.GJ10189@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 19, 2016 at 05:41:50PM +0800, Ayaka wrote:
> ??? iPad ??

Please fix your mail client to word wrap within paragraphs at something
substantially less than 80 columns.  Doing this makes your messages much
easier to read and reply to.

> > Are you *sure* simple-card works for AC'97?

> Not sure. I could hardly find a AC97 device in embedded market. If it
> didn't I could disable it. I have only tested simple sound card for
> i2s and SPDIF.

I would be very surprised if it does and AC'97 is supposed to be
enumerable and not need a card binding anyway so best to remove this one
for the time being.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160919/c6b270fe/attachment.sig>
