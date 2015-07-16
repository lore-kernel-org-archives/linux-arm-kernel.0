From: marex@denx.de (Marek Vasut)
Date: Thu, 16 Jul 2015 19:44:20 +0200
Subject: [PATCH 4/7] Documentation: mtd: add a DT property to set the
 latency code of Spansion memory
In-Reply-To: <398ca9f17bda638e05e97f258fb4e6d27ac828db.1437059658.git.cyrille.pitchen@atmel.com>
References: <cover.1437059658.git.cyrille.pitchen@atmel.com>
 <398ca9f17bda638e05e97f258fb4e6d27ac828db.1437059658.git.cyrille.pitchen@atmel.com>
Message-ID: <201507161944.20523.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, July 16, 2015 at 05:27:51 PM, Cyrille Pitchen wrote:

Hi!

> Both the SPI controller and the NOR flash memory need to agree on the
> number of dummy cycles to use for Fast Read commands. For Spansion
> memories, this number of dummy cycles is not given directly but through a
> so called "latency code".
> The latency code can be found into the memory datasheet and depends on the
> SPI clock frequency, the Fast Read op code and the Single/Dual Data Rate
> mode.

Shouldn't you be able to derive the latency code from the above information,
which you already know then ?

Best regards,
Marek Vasut
