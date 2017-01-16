From: a.aubert@overkiz.com (Antoine Aubert)
Date: Mon, 16 Jan 2017 08:45:58 +0100
Subject: USB: OHCI: high softirq load
Message-ID: <bd83e3b2-b329-3635-2917-0ffe61d3535f@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Im working on a AT91SAM9G25cu board
(arch/arm/boot/dts/at91-kizboxmini.dts). We use linux-4.1.31, and when
OHCI is enabled, I got some wired effects.

eg with 3 FTDI pluged, interrupts: more than 3.5k/s, cpu softirq > 24%,
loadavg > 0.5

This issue disappear when disabling OHCI and use EHCI only.

What are the usual causes, and where to begin with ?

Thanks in advance,

-- 
Antoine Aubert
a.aubert at overkiz.com
