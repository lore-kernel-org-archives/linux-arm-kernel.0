From: david.lanzendoerfer@o2s.ch (David =?iso-8859-1?q?Lanzend=F6rfer?=)
Date: Fri, 3 Sep 2010 17:01:31 +0200
Subject: Keyboard for HTC-Dream
In-Reply-To: <20100816055540.GA1455@ucw.cz>
References: <201008071307.40988.david.lanzendoerfer@o2s.ch>
	<20100816055540.GA1455@ucw.cz>
Message-ID: <201009031701.34609.david.lanzendoerfer@o2s.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi
Following thing:
I've now imported board-trout-keypad.c from android kernel
and modded the includepaths to make it build.
It also shows me over already running usb ethernet
over dmesg, that the GPIO matrix gets loaded but.
Following occurs:
--------dmesg--------
[   24.800000] gpiomatrix: set_irq_wake failed for input 42, irq 106
[   24.810000] gpiomatrix: set_irq_wake failed for input 41, irq 105
[   24.810000] gpiomatrix: set_irq_wake failed for input 40, irq 104
[   24.820000] gpiomatrix: set_irq_wake failed for input 39, irq 103
[   24.830000] gpiomatrix: set_irq_wake failed for input 38, irq 102
[   24.840000] gpiomatrix: set_irq_wake failed for input 37, irq 101
[   24.850000] gpiomatrix: set_irq_wake failed for input 36, irq 100
[   24.860000] GPIO Matrix Keypad Driver: Start keypad matrix for trout-keypad-qwertz in interrupt mode
[   24.870000] setting trigger mode 3 for irq 84 failed (msm_gpio_irq_set_type+0x0/0x118)
[   24.880000] gpio_event_input_request_irqs: request_irq failed for input 20, irq 84
[   24.890000] GPIO Input Driver: Start gpio inputs for trout-keypad-qwertz in polling mode
[   24.900000] GPIO Input Driver: Start gpio inputs for trout-keypad-qwertz in polling mode
[   24.910000] input: trout-keypad-qwertz as /devices/virtual/input/input0
------------------------
And as soon as I try to type something, the kernel totaly freezes.

Any idea?

best regards
	leviathan
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100903/aa7613f1/attachment.sig>
