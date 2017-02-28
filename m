From: bgolaszewski@baylibre.com (Bartosz Golaszewski)
Date: Tue, 28 Feb 2017 17:21:10 +0100
Subject: [PATCH] media: vpif: request enable-gpios
In-Reply-To: <1487770071-5157-1-git-send-email-bgolaszewski@baylibre.com>
References: <1487770071-5157-1-git-send-email-bgolaszewski@baylibre.com>
Message-ID: <CAMpxmJU=CBxRPcK0jgbktdPJZtbdbviE_sphFSBdTjfvaYtYDg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2017-02-22 14:27 GMT+01:00 Bartosz Golaszewski <bgolaszewski@baylibre.com>:
> This change is needed to make vpif capture work on the da850-evm board
> where the capture function must be selected on the UI expander.
>
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>  drivers/media/platform/davinci/vpif_capture.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>

Disregard this patch - we need to determine a better solution for this
functionality.

Thanks,
Bartosz
