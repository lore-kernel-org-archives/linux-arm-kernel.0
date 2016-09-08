From: robh+dt@kernel.org (Rob Herring)
Date: Wed, 7 Sep 2016 19:58:43 -0500
Subject: [PATCH v4 02/22] of: device: Export of_device_{get_modalias,
 uvent_modalias} to modules
In-Reply-To: <20160907213519.27340-3-stephen.boyd@linaro.org>
References: <20160907213519.27340-1-stephen.boyd@linaro.org>
 <20160907213519.27340-3-stephen.boyd@linaro.org>
Message-ID: <CAL_JsqKE=K+p6dtgfEP7pCij07BfyOBw_scLV6O1eEn8N9hsAQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 7, 2016 at 4:34 PM, Stephen Boyd <stephen.boyd@linaro.org> wrote:
> The ULPI bus can be built as a module, and it will soon be
> calling these functions when it supports probing devices from DT.
> Export them so they can be used by the ULPI module.
>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: <devicetree@vger.kernel.org>
> Signed-off-by: Stephen Boyd <stephen.boyd@linaro.org>
> ---
>  drivers/of/device.c | 2 ++
>  1 file changed, 2 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>
