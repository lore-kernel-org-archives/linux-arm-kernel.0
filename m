From: broonie@kernel.org (Mark Brown)
Date: Thu, 19 Apr 2018 15:55:23 +0100
Subject: [PATCH 2/3] dt-bindings: add binding for at91-usart in spi mode
In-Reply-To: <68cdbb8b60c32980caa7b130409d05d28788edd9.camel@microchip.com>
References: <20180413161117.20274-1-radu.pirea@microchip.com>
 <20180413161117.20274-3-radu.pirea@microchip.com>
 <20180413162327.GE22187@piout.net>
 <8e6c447d-dce5-f9af-e5b2-8d1d863159d6@microchip.com>
 <20180413181251.GG22187@piout.net>
 <20180417110358.GD8973@sirena.org.uk>
 <68cdbb8b60c32980caa7b130409d05d28788edd9.camel@microchip.com>
Message-ID: <20180419145523.GH27188@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 19, 2018 at 01:04:16PM +0300, Radu Pirea wrote:

> Thank you for suggestions. I followed your advice and looked at PXA SSP
> driver. In my opinion it is a layer that avoids collsions and
> unfortunately complicates things a bit. My ideea is to keep the things
> as simple as possible. For example, I can enhance usart-serial and
> usart-spi drivers to print detailed messages if probe fails because one
> driver tries to request a memory region already used by another driver.
> What do you think? Is this approach a good way to move forward?

Alexandre's suggestion using a MFD with a property to select the mode
seems more solid TBH.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180419/b5b2325f/attachment.sig>
