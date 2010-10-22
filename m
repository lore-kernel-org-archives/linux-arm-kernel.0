From: alan@lxorguk.ukuu.org.uk (Alan Cox)
Date: Fri, 22 Oct 2010 15:20:24 +0100
Subject: [PATCH v3 01/12] misc: add driver for sequencer serial port
In-Reply-To: <1287694873-12904-2-git-send-email-cyril@ti.com>
References: <1287694873-12904-1-git-send-email-cyril@ti.com>
	<1287694873-12904-2-git-send-email-cyril@ti.com>
Message-ID: <20101022152024.65e8f181@lxorguk.ukuu.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 21 Oct 2010 17:01:02 -0400
Cyril Chemparathy <cyril@ti.com> wrote:

> TI's sequencer serial port (TI-SSP) is a jack-of-all-trades type of serial port
> device.  It has a built-in programmable execution engine that can be programmed
> to operate as almost any serial bus (I2C, SPI, EasyScale, and others).
> 
> This patch adds a driver for this controller device.  The driver does not
> expose a user-land interface.  Protocol drivers built on top of this layer are
> expected to remain in-kernel.

I suspect the driver belongs with the mfd drivers not with drivers/misc ?

otherwise it looks very nice.
