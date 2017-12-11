From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 11 Dec 2017 08:21:25 +0100
Subject: [PATCH v2] ARM: dts: Add ethernet PHYs to the a bunch of Geminis
In-Reply-To: <20171203160658.GB7878@lunn.ch>
References: <20171203150457.21774-1-linus.walleij@linaro.org>
 <20171203160658.GB7878@lunn.ch>
Message-ID: <CACRpkda0BCUjJEOJ-jLW6RzuRNLuJ0vnVONXPjavQGBBjZJL9A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Dec 3, 2017 at 5:06 PM, Andrew Lunn <andrew@lunn.ch> wrote:
> On Sun, Dec 03, 2017 at 04:04:57PM +0100, Linus Walleij wrote:
>> These Gemini boards have Ethernet PHY on GPIO bit-banged
>> MDIO, clearly defined in the corresponding OpenWRT
>> ethernet patches since ages. Add them in accordance with
>> the OpenWRT patch so we can use them when we add ethernet
>> support.
>>
>> Cc: Andrew Lunn <andrew@lunn.ch>
>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>

Thanks man.

> This is good as is, but i just wonder if the mdio node can be moved
> into the .dtsi file. Four from six have the exact same setup. So i'm
> guessing the reference design has been copied.

Yeah they all have the GPIO lines similarly so far.
I might break out a DTSI with common stuff based on the
reference design. The main DTSI should be the chipset
but we can surely have a gemi-standard-board.dtsi as well.

Yours,
Linus Walleij
