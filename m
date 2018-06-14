From: broonie@kernel.org (Mark Brown)
Date: Thu, 14 Jun 2018 14:48:01 +0100
Subject: [PATCH 1/2] ASoC: pxa: add binding for pxa2xx-ac97 audio complex
In-Reply-To: <87y3fiqzp8.fsf@belgarion.home>
References: <20180611202211.15501-1-robert.jarzmik@free.fr>
 <20180612221359.GA26741@rob-hp-laptop>
 <87y3fiqzp8.fsf@belgarion.home>
Message-ID: <20180614134801.GB9660@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 13, 2018 at 09:00:19PM +0200, Robert Jarzmik wrote:
> Rob Herring <robh@kernel.org> writes:
> > On Mon, Jun 11, 2018 at 10:22:10PM +0200, Robert Jarzmik wrote:

> >> +Required properties:
> >> +  - compatible: "marvell,pxa2xx-ac97"

> > Don't use wildcards in compatible strings. Though this is so old...

> Yes, I could use pxa270-ac97.

If you're going to do that then probably best to put in a compatible
string for each SoC since they are actually meaningfully different, they
seemed to manage to break something with each new revision.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 484 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180614/31b38c15/attachment.sig>
