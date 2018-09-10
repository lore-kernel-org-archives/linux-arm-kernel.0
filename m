From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Mon, 10 Sep 2018 20:45:55 +0200
Subject: [PATCH] arm64: dts: meson-axg-s400: Add chosen and memory nodes
In-Reply-To: <1536604395-31925-1-git-send-email-narmstrong@baylibre.com>
References: <1536604395-31925-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <CAFBinCDeHVZ5s2f5xhuRByg7pt+MTqqfO8_5C_s_B3hbZkDANg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 10, 2018 at 8:33 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> Add missing chosen and memory nodes.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
out of curiosity:
- does the bootloader add the memory node (meaning that this is just a
cosmetic bit)?
- setting stdout-path is always a good idea, without it you can't use
earlycon (without parameters)

Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
