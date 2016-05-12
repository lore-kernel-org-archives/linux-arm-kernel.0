From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 12 May 2016 15:41:12 +0200
Subject: [PATCH 1/6] pinctrl: meson: Fix eth_tx_en bit index
In-Reply-To: <m2r3d97wnc.fsf@baylibre.com>
References: <1462910920-5462-1-git-send-email-serveralex@gmail.com>
 <1462910920-5462-2-git-send-email-serveralex@gmail.com>
 <m2r3d97wnc.fsf@baylibre.com>
Message-ID: <CACRpkda40Gb4ye7_dBwOcsWZTT2V6qByVOyv_Z_Mg4RX+CLNiA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 11, 2016 at 11:48 AM, Kevin Hilman <khilman@baylibre.com> wrote:
> Alexander M?ller <serveralex@gmail.com> writes:
>
>> Fix pinctrl eth_tx_en bit index according to Hardkernel ODROID-C1 datasheet.
>>
>> Signed-off-by: Alexander M?ller <serveralex@gmail.com>
>
> Tested-by: Kevin Hilman <khilman@baylibre.com>
>
> Linus, with your ack, we can take this through the amlogic tree, or feel
> free to merge as a fix as it can go independetly of the rest of the
> series if needed.

I've merged this patch.

Yours,
Linus Walleij
