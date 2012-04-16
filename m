From: philipp.zabel@gmail.com (Philipp Zabel)
Date: Mon, 16 Apr 2012 22:16:28 +0200
Subject: [PATCH] ARM: pxa: hx4700: Enable ASIC3 GPIO as a wakeup source
In-Reply-To: <1334105051.49438.YahooMailClassic@web29020.mail.ird.yahoo.com>
References: <1334105051.49438.YahooMailClassic@web29020.mail.ird.yahoo.com>
Message-ID: <1334607388.30492.1.camel@flow>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, den 11.04.2012, 01:44 +0100 schrieb Paul Parsons:
> This patch enables the ASIC3 GPIO (12) as a wakeup source:
> 1. Set the WAKEUP_ON_EDGE_RISE MFP config bits for GPIO12 in
> hx4700_pin_config[].
> 2. Call gpio_set_wake() for GPIO12.

Acked-by: Philipp Zabel <philipp.zabel@gmail.com>
