From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 08 Oct 2015 17:43:11 +0200
Subject: [PATCH 1/4] dt-bindings: Document the STM32 DMA bindings
In-Reply-To: <1444317612-818-2-git-send-email-cedric.madianga@gmail.com>
References: <1444317612-818-1-git-send-email-cedric.madianga@gmail.com>
 <1444317612-818-2-git-send-email-cedric.madianga@gmail.com>
Message-ID: <13614799.2Hi64P0fJ2@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 08 October 2015 17:20:09 M'boumba Cedric Madianga wrote:
> +Each dmas request consists of 5 cells:
> +1. A phandle pointing to the STM32 DMA controller
> +2. The channel id
> +3. The request line number
> +4. A 32bit mask specifying the DMA channel configuration
> 

It's fairly unusual to encode the channel id here, rather than
letting the driver pick one. Is that actually required here?

	Arnd
