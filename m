From: broonie@kernel.org (Mark Brown)
Date: Mon, 28 Jul 2014 22:28:31 +0100
Subject: [PATCH v2 09/11] Documentation: devicetree: Fix ADI AXI SPDIF
 specification
In-Reply-To: <53D66EC2.1050408@suse.de>
References: <53D20A61.1050506@metafoo.de> <53D21066.8000905@monstr.eu>
 <20140725101815.GO17528@sirena.org.uk> <53D2324B.4070602@suse.de>
 <20140725103905.GP17528@sirena.org.uk> <53D63746.3000905@suse.de>
 <20140728122042.GR17528@sirena.org.uk> <53D641DC.4020804@suse.de>
 <20140728134420.GU17528@sirena.org.uk> <53D66EC2.1050408@suse.de>
Message-ID: <20140728212831.GF17528@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 28, 2014 at 05:39:46PM +0200, Andreas F?rber wrote:

> Similarly, your statement about false negatives didn't really help in
> resolving the not-CC'ed problem. I now know to CC you if I ever have
> something for adi,axi-spdif-tx.txt again, but the next person might make
> you grumpy again and potentially demotivates new contributors, so
> certainly worth fixing.

> Regmap, SPI, regulators, touchscreen MAINTAINERS entries seem unrelated.
> Should your "SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEMENT (ASoC)"
> MAINTAINERS entry get an
> F: Documentation/devicetree/bindings/sound/
> or is the "ANALOG DEVICES Inc ASOC DRIVERS" entry missing a line
> F: sound/soc/adi/
> F: Documentation/devicetree/bindings/sound/adi,axi-spdif-tx.txt
> (which would then still not CC you)
> or is a new MAINTAINERS section needed that CCs specifically Lars-Peter
> and you on the latter?

What you're really talking about is making MAINTAINERS complete which is
a very big job; even if only looking at the DT bindings you'd need to go
through every binding and make sure that MAINTAINERS says the same
things as it does for the matching driver code, and where there are
missing entries add them.  In the immediate case both bits are missing.

Really as with so much else it's much better advice to ask people to
look and think about what they're doing; it's the same thing as ensuring
that commit logs match the standard style for the thing being edited
(especially the subject lines) and that if there's people who normally
apply patches and work on the code they're included.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140728/f5f09457/attachment.sig>
