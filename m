From: hch@infradead.org (Christoph Hellwig)
Date: Tue, 7 Aug 2018 06:32:30 -0700
Subject: [PATCH v3 1/2] tty/serial_core: add ISO7816 infrastructure
In-Reply-To: <20180807130049.5957-2-ludovic.desroches@microchip.com>
References: <20180807130049.5957-1-ludovic.desroches@microchip.com>
 <20180807130049.5957-2-ludovic.desroches@microchip.com>
Message-ID: <20180807133230.GA26577@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 07, 2018 at 03:00:48PM +0200, Ludovic Desroches wrote:
> From: Nicolas Ferre <nicolas.ferre@microchip.com>
> 
> Add the ISO7816 ioctl and associated accessors and data structure.
> Drivers can then use this common implementation to handle ISO7816.

It would help a lot of you'd explain what ISO7816 is.  Without that
the changelog is rather meaningless.
