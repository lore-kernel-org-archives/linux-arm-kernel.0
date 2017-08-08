From: vincent.legoll@gmail.com (Vincent Legoll)
Date: Tue, 8 Aug 2017 13:56:05 +0200
Subject: [linux-sunxi] [PATCH v3 1/5] dt-bindings: update the Allwinner
 GPADC device tree binding for H3
In-Reply-To: <20170723141354.42646-2-icenowy@aosc.io>
References: <20170723141354.42646-1-icenowy@aosc.io>
 <20170723141354.42646-2-icenowy@aosc.io>
Message-ID: <CAEwRq=oJDmUBhb5n5=X-M5NL7855yW0t2J=TOJf0WSmBQuKyVQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

Sorry for the very-clueless question

On Sun, Jul 23, 2017 at 4:13 PM, Icenowy Zheng <icenowy@aosc.io> wrote:
> +  - clock-names: should be "bus" and "mod",

When I first read that, I wondered what value clock-names should
eally be given.

Then...

> +               clock-names = "bus", "mod";

OK, now this is clearer, but still the documentation is less documenting
than the code itself, sigh...

I cannot think of a better wording, though, as a non-native-english
speaker. Maybe just add a "(See example below)" would be
sufficient...

Or decide that this documentation is for clueful ones.

WDYT ?

-- 
Vincent Legoll
