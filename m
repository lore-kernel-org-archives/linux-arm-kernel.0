From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Sat, 13 Jan 2018 10:57:45 +0100 (CET)
Subject: [PATCH v2 1/4] ARM: bcm2835: sync firmware properties with
 downstream
In-Reply-To: <e68675d54955c754ebe8ffc2491585fde5b396bc.1515698418.git.baruch@tkos.co.il>
References: <cover.1515698418.git.baruch@tkos.co.il>
 <e68675d54955c754ebe8ffc2491585fde5b396bc.1515698418.git.baruch@tkos.co.il>
Message-ID: <1991337128.42939.1515837465503@email.1und1.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> Baruch Siach <baruch@tkos.co.il> hat am 11. Januar 2018 um 20:44 geschrieben:
> 
> 
> Add latest firmware property tags from the latest Raspberry Pi downstream
> kernel. This is needed for the GPIO tags, so we can control the GPIO
> multiplexor lines.
> 
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>

Acked-by: Stefan Wahren <stefan.wahren@i2se.com>

Maybe this is obvious, but patch #3 depends on this change so no cherry-picking allowed.
