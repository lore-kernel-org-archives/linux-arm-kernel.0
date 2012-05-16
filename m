From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Wed, 16 May 2012 18:58:12 +1000
Subject: linux-next: manual merge of the arm-soc tree with the staging tree
Message-ID: <20120516185812.ce1ab57c3ec72445135a35fc@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the arm-soc tree got a conflict in
arch/arm/boot/dts/at91sam9g20.dtsi between commit 7cb2e629a240 ("ARM:
AT91: Add ADC driver to the at91sam9g20 dtsi") from the staging tree and
commit 5b6089cb6f28 ("ARM: at91: add at91sam9260 DT support") from the
arm-soc tree.

So, I didn't know what to do with this, so I used the arm-soc version of
this file (effectively throwing away the staging tree change).  Hints,
anyone?
-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120516/c5138872/attachment.sig>
