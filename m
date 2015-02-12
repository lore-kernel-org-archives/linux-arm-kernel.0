From: notasas@gmail.com (Grazvydas Ignotas)
Date: Thu, 12 Feb 2015 16:35:14 +0200
Subject: [PATCH 0/4] add openpandora device support
In-Reply-To: <1423746226-700-1-git-send-email-marek@goldelico.com>
References: <1423746226-700-1-git-send-email-marek@goldelico.com>
Message-ID: <CANOLnOPZ5j-r9APq6WrW65iOyNQPT4M_uRgN+xp9Mrp4zgVn7w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 12, 2015 at 3:03 PM, Marek Belisko <marek@goldelico.com> wrote:
> This series of patches adds initial device tree support for the
> OpenPandora. The most important parts are working (display, keyboard,
> touch, charging, fuel gauge, musb port, sd/mmc ports, leds, buttons).
> Not yet supported are: usb host port, nubs, wifi, bluetooth, audio.
>
> First patch add common dtsi file which is then used in 600mhz and 1ghz
> variants of openpandora which support is added in patches 2 and 3.

Nice, thanks for those patches.
There is also a OMAP3530 variant with 256MB of RAM (otherwise
identical to 512MB OMAP3530) that the legacy board file supports, over
1000 such units were made. Could we also have support for that? I
guess that will make 4 pandora related .dts files...


Gra?vydas
