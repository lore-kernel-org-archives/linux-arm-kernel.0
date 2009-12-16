From: eric.y.miao@gmail.com (Eric Miao)
Date: Wed, 16 Dec 2009 16:13:21 +0800
Subject: [PATCH] pxa/pcmcia: Fix pxa2xx PCMCIA oops
In-Reply-To: <20091216075807.GB21992@comet.dominikbrodowski.net>
References: <20091215211121.2cb4f5ac@taxman.wild-wind.fr.eu.org>
	<20091216075807.GB21992@comet.dominikbrodowski.net>
Message-ID: <f17812d70912160013p1766f229j81247937407fcb1@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 16, 2009 at 3:58 PM, Dominik Brodowski
<linux@dominikbrodowski.net> wrote:
> On Tue, Dec 15, 2009 at 09:11:21PM +0100, Marc Zyngier wrote:
>> Commit d0d26c33b63c7ec10c3fdf9c7ce0aa035f0b3200:
>>
>> PCMCIA: fix pxa2xx_lubbock modular build error
>>
>> broke the driver by propagating a pointer to the platform_device
>> where a pointer to the generic device was expected, leading to a
>> spectacular crash...
>>
>> Signed-off-by: Marc Zyngier <maz@misterjones.org>
> Acked-by: Dominik Brodowski <linux@dominikbrodowski.net>
>

Dominik,

Maybe you can help upstream this, and if you want my Ack, here it is:

Acked-by: Eric Miao <eric.y.miao@gmail.com>
