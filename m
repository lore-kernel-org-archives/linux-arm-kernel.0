From: notasas@gmail.com (Grazvydas Ignotas)
Date: Fri, 20 Feb 2015 00:55:14 +0200
Subject: [PATCH v2 0/3] ARM: dts: add openpandora device support
In-Reply-To: <1424202743-26387-1-git-send-email-marek@goldelico.com>
References: <1424202743-26387-1-git-send-email-marek@goldelico.com>
Message-ID: <CANOLnOOMLxDV6vQagfRaS7_YY6at91BbL0jPKkNQn-tYDnJEuw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 17, 2015 at 9:52 PM, Marek Belisko <marek@goldelico.com> wrote:
> changes from v1:
> - add new boards to makefile in patch 2,3 (don't add them
> in separate commit together), fix gpmc issues (reported by Tony Lindgren)
>
> - fix various issues reported by Grazvydas Ignotas
> (drop internal pullups from pinmux as external are in place,
> fix gpio buttons active state ...)
>
> This series of patches adds initial device tree support for the
> OpenPandora. The most important parts are working (display, keyboard,
> touch, charging, fuel gauge, musb port, sd/mmc ports, leds, buttons).

All of these have been tested to be working, after adding missing
input flag for touchscreen. Well except musb, but I often have trouble
with that in mainline, probably not a problem with this dts.
Tested-by: Grazvydas Ignotas <notasas@gmail.com>

And FWIW, the patches have been
Reviewed-by: Grazvydas Ignotas <notasas@gmail.com>
