From: afaerber@suse.de (=?ISO-8859-1?Q?Andreas_F=E4rber?=)
Date: Mon, 28 Jul 2014 17:39:46 +0200
Subject: [PATCH v2 09/11] Documentation: devicetree: Fix ADI AXI SPDIF
 specification
In-Reply-To: <20140728134420.GU17528@sirena.org.uk>
References: <1406242820-20140-1-git-send-email-afaerber@suse.de>
 <1406242820-20140-10-git-send-email-afaerber@suse.de>
 <53D20A61.1050506@metafoo.de> <53D21066.8000905@monstr.eu>
 <20140725101815.GO17528@sirena.org.uk> <53D2324B.4070602@suse.de>
 <20140725103905.GP17528@sirena.org.uk> <53D63746.3000905@suse.de>
 <20140728122042.GR17528@sirena.org.uk> <53D641DC.4020804@suse.de>
 <20140728134420.GU17528@sirena.org.uk>
Message-ID: <53D66EC2.1050408@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 28.07.2014 15:44, schrieb Mark Brown:
> On Mon, Jul 28, 2014 at 02:28:12PM +0200, Andreas F?rber wrote:
> 
>> I will *re*-submit it for your convenience.
> 
> Which is what I originally requested when I got CCed into the thread -
> I'm being grumpy because instead of getting the patch sent to me as
> requested I got sent a link to patchwork.

Hindsight, had you simply replied with "Yes, please." instead of the
non-telling "Documentation/SubmittingPatches.", you would've spared
yourself keystrokes and us four mailing list messages. ;)

Similarly, your statement about false negatives didn't really help in
resolving the not-CC'ed problem. I now know to CC you if I ever have
something for adi,axi-spdif-tx.txt again, but the next person might make
you grumpy again and potentially demotivates new contributors, so
certainly worth fixing.

Regmap, SPI, regulators, touchscreen MAINTAINERS entries seem unrelated.
Should your "SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEMENT (ASoC)"
MAINTAINERS entry get an
F: Documentation/devicetree/bindings/sound/
or is the "ANALOG DEVICES Inc ASOC DRIVERS" entry missing a line
F: sound/soc/adi/
F: Documentation/devicetree/bindings/sound/adi,axi-spdif-tx.txt
(which would then still not CC you)
or is a new MAINTAINERS section needed that CCs specifically Lars-Peter
and you on the latter?

Regards,
Andreas

-- 
SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Jeff Hawn, Jennifer Guild, Felix Imend?rffer; HRB 16746 AG N?rnberg

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140728/ba5abc57/attachment.sig>
