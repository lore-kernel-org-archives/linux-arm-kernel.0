From: broonie@kernel.org (Mark Brown)
Date: Wed, 24 May 2017 18:29:40 +0100
Subject: [PATCH RFC 0/5] *** SPI Slave mode support ***
In-Reply-To: <59019306.2050309@mentor.com>
References: <1492085644-4195-1-git-send-email-jiada_wang@mentor.com>
 <20170413125929.dygodgj6c35ydh5p@sirena.org.uk>
 <CAMuHMdUm=90ddNWM5KWqT+W0hqZ-QO6vPHj5OisbYquDYq1ZmA@mail.gmail.com>
 <58F06092.9080409@mentor.com>
 <CAMuHMdXa_O6RsqUciiNWQ0Zp6dniS47AUmPN9UWAWitP0csx=Q@mail.gmail.com>
 <20170425103113.lxpwoq6sbxvg3ihl@sirena.org.uk>
 <59019306.2050309@mentor.com>
Message-ID: <20170524172940.6vypisacs3rmmjws@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 26, 2017 at 11:43:18PM -0700, Jiada Wang wrote:

> The reason I gave the example use case is want to point out that
> with Geert's patch set, a SPI device (with only one controller) can no
> longer
> act as master and slave at the same time. because IMO as a SPI core
> function,
> it needs to cover all the use cases, and to be as generic as possible.

> BUT if you think the use case don't need to be supported from SPI core,
> then I don't have objection either, I will only submit imx SPI slave support
> patch,
> after your SPI slave support patch set been applied

I think there's a bunch of other problems with how that works reliably
that'd need to be addressed before someone could actually do that, and
it seems like such hardware will be very unusual.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170524/3669a671/attachment.sig>
