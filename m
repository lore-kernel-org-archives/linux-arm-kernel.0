From: robh+dt@kernel.org (Rob Herring)
Date: Mon, 9 Oct 2017 19:50:38 -0500
Subject: [PATCH v3 1/5] of/platform: Generalize /reserved-memory handling
In-Reply-To: <20171005033258.12825-2-bjorn.andersson@linaro.org>
References: <20171005033258.12825-1-bjorn.andersson@linaro.org>
 <20171005033258.12825-2-bjorn.andersson@linaro.org>
Message-ID: <CAL_JsqKVBC8CoXotxoruO-89VMdUtb1HhcfOsyd7JiFwJ4dCfA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 4, 2017 at 10:32 PM, Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
> By iterating over all /reserved-memory child nodes and match each one to
> a list of compatibles that we want to treat specially, we can easily
> extend the list of compatibles to handle - without having to resort to
> of_platform_populate() that would create unnecessary platform_devices.
>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---

Reviewed-by: Rob Herring <robh@kernel.org>
