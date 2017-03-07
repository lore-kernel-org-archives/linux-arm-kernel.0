From: bgolaszewski@baylibre.com (Bartosz Golaszewski)
Date: Tue, 7 Mar 2017 12:50:34 +0100
Subject: [PATCH] media: vpif: use a configurable i2c_adapter_id for vpif
 display
In-Reply-To: <1487268481-6127-1-git-send-email-bgolaszewski@baylibre.com>
References: <1487268481-6127-1-git-send-email-bgolaszewski@baylibre.com>
Message-ID: <CAMpxmJXbJn8oEhB8g_6AsDxZPqDQf7eTnqkUwr_dMP=BNL+q+Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2017-02-16 19:08 GMT+01:00 Bartosz Golaszewski <bgolaszewski@baylibre.com>:
> The vpif display driver uses a static i2c adapter ID of 1 but on the
> da850-evm board in DT boot mode the i2c adapter ID is actually 0.
>
> Make the adapter ID configurable like it already is for vpif capture.
>
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> Acked-by: Kevin Hilman <khilman@baylibre.com>
> ---

Hi Mauro, Prabhakar,

can we get an ack on this? Sekhar already merged the rest of the
patches that need this to make vpif display work on the da850-evm
board. I think it's best if it goes through his tree.

Thanks,
Bartosz
