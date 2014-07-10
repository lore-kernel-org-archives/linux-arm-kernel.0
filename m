From: emilio@elopez.com.ar (=?ISO-8859-1?Q?Emilio_L=F3pez?=)
Date: Thu, 10 Jul 2014 13:20:12 -0300
Subject: [PATCH v2 2/8] spi: sun4i: add DMA support
In-Reply-To: <20140710122227.GC27469@lukather>
References: <1404619518-7592-1-git-send-email-emilio@elopez.com.ar>
 <1404619518-7592-3-git-send-email-emilio@elopez.com.ar>
 <20140710122227.GC27469@lukather>
Message-ID: <53BEBD3C.9@elopez.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

El 10/07/14 09:22, Maxime Ripard escribi?:
> Hi Emilio,
>
> On Sun, Jul 06, 2014 at 01:05:09AM -0300, Emilio L?pez wrote:
>> This patch adds DMA support for 64 byte transfers on the sun4i SPI
>> controller. Bigger transfers did not seem to work when tested, and if
>> the hardware actually supports those, it will need further
>> investigation as to how to issue them correctly.
>>
>> Signed-off-by: Emilio L?pez <emilio@elopez.com.ar>
>
> This patch looks fine from a quick look, but you should put Mark Brown
> in the recipients, since he's the SPI maintainer, and will probably
> have a sharper look.

Thanks for the heads up, I'll Cc him as well as the SPI list on v3

Cheers!

Emilio
