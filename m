From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Thu, 24 Nov 2016 17:52:20 +0100
Subject: [net-next PATCH v1 1/2] net: dt-bindings: add RGMII TX delay
 configuration to meson8b-dwmac
In-Reply-To: <20161124154858.GB20455@lunn.ch>
References: <20161124143417.10178-1-martin.blumenstingl@googlemail.com>
 <20161124143417.10178-2-martin.blumenstingl@googlemail.com>
 <20161124154858.GB20455@lunn.ch>
Message-ID: <CAFBinCCc_CEm-ujR5vrBuQnoRcDMuuo+T0usQ3O5+5t5b+9UrQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew,

On Thu, Nov 24, 2016 at 4:48 PM, Andrew Lunn <andrew@lunn.ch> wrote:
>> The configuration values are provided as preprocessor macros to make the
>> devicetree files easier to read.
>
> Hi Martin
>
> If i'm reading the code/comments correctly, you can set the delay to
> 0, 2, 4 or 6ns? So calling this property amlogic,tx-delay-ns would be
> even easier to read.
indeed, this sounds like a very nice idea (as it moves the calculation
from the programmer's brain to dwmac-meson8b.c)!

I'll send an updated version once I received enough feedback (in case
something else is wrong with the patches)
