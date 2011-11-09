From: pebolle@tiscali.nl (Paul Bolle)
Date: Wed, 09 Nov 2011 21:45:00 +0100
Subject: CONFIG_USB_MUSB_PERIPHERAL
Message-ID: <1320871500.27598.40.camel@x61.thuisdomein>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

0) Commit 622859634a663c5e55d0e2a2cdbb55ac058d97b3 ("usb: musb: drop a
gigantic amount of ifdeferry") dropped config USB_MUSB_PERIPHERAL. But
currently there are still five references to CONFIG_USB_MUSB_PERIPHERAL
(all in arch/arm).

1) I could try to fix those five references (as they only influence a
trivial amount of code). But I guess that you people could come up with
a better solution with less effort. Ie, I choose the easy way out.


Paul Bolle
