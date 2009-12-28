From: broonie@sirena.org.uk (Mark Brown)
Date: Mon, 28 Dec 2009 19:00:09 +0000
Subject: Ethernet in a cold climate / SMDK6410
In-Reply-To: <4B38FB80.9050609@warmcat.com>
References: <4B38FB80.9050609@warmcat.com>
Message-ID: <20091228190009.GB14799@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 28, 2009 at 06:40:00PM +0000, Andy Green wrote:

> What is the deal with that in terms of SDMK settings and assumptions
> about bootloader prepping nCS signals?  SMDK docs I have let me
> twiddle switches and get "ethernet" connected to various selects.
> What does 0x18000000 represent and how should the board be set so
> CS8900A doesn't crash the party?

I've never used the board with the CS8900A enabled, the bootloaders I've
seen appear to support the SMSC chip only.

The memory address was lifted from the Samsung BSP code IIRC.
