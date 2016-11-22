From: broonie@kernel.org (Mark Brown)
Date: Tue, 22 Nov 2016 18:08:17 +0000
Subject: [alsa-devel] [PATCH 2/9] ALSA: ac97: add an ac97 bus
In-Reply-To: <6b97a129-bd10-b9be-616d-a3ea3b91b103@metafoo.de>
References: <1477510907-23495-1-git-send-email-robert.jarzmik@free.fr>
 <1477510907-23495-3-git-send-email-robert.jarzmik@free.fr>
 <d57cdfba-da22-652d-3d75-6d1b754cf1d5@metafoo.de>
 <87eg2ly8k6.fsf@belgarion.home>
 <5ae15e01-eaaf-4996-27ec-1179041c0268@metafoo.de>
 <87mvh8uywm.fsf@belgarion.home>
 <6b97a129-bd10-b9be-616d-a3ea3b91b103@metafoo.de>
Message-ID: <20161122180817.2gqkjal76smnyp63@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 10, 2016 at 12:38:40PM +0100, Lars-Peter Clausen wrote:
> On 11/09/2016 10:27 PM, Robert Jarzmik wrote:

> > here, ie. that the rescan is a bug, or if it's more an "Occam's razor"
> > discussion ?

> Maybe we can just leave the rescanning out for now and think about how to
> best handle it when the need arises.

Yes, I think that's best - I suspect it'd be something that'd need to be
triggered by a driver for an AC'97 CODEC doing power management but I
imagine that if we were going to have such a system we'd have run into
it already anyway.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 455 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161122/3891c7e3/attachment.sig>
