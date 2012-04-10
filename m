From: philipp.zabel@gmail.com (Philipp Zabel)
Date: Tue, 10 Apr 2012 21:21:18 +0200
Subject: [PATCH 2/3 v6] ARM: pxa: hx4700: Add PCMCIA/CF support
In-Reply-To: <1333644241.54055.YahooMailClassic@web29001.mail.ird.yahoo.com>
References: <1333644241.54055.YahooMailClassic@web29001.mail.ird.yahoo.com>
Message-ID: <1334085678.6046.6.camel@flow>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, den 05.04.2012, 17:44 +0100 schrieb Paul Parsons:
> This patch is part of a set which adds PCMCIA/CF support for the hx4700.
> This patch modifies asic3_gpio_config[] as follows:
> 1. Remove ASIC3_GPIOC4_CF_nCD, whose purpose is unknown.
> 2. Add ASIC3_GPIOD4_CF_nCD, the actual CF card detect GPIO.
> 
> Signed-off-by: Paul Parsons <lost.distance@yahoo.com>
> Cc: Philipp Zabel <philipp.zabel@gmail.com>

Acked-by: Philipp Zabel <philipp.zabel@gmail.com>

regards
Philipp
