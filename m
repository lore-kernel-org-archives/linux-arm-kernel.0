From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Wed, 1 Aug 2018 11:58:58 +0200
Subject: next/master boot: 179 boots: 11 failed,
 167 passed with 1 offline (next-20180731)
In-Reply-To: <c50e3311-9dca-c64b-ca58-6a44e3559e98@st.com>
References: <5b607cc4.1c69fb81.6c1d6.6534@mx.google.com>
 <20180731160623.GH5719@sirena.org.uk>
 <c50e3311-9dca-c64b-ca58-6a44e3559e98@st.com>
Message-ID: <CAPDyKFoJ173XKL-xSRJtvk5_3E2cx1Pb-rs=7g9d9+Gt8QAOqQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1 August 2018 at 10:19, Ludovic BARRE <ludovic.barre@st.com> wrote:
> hi Mark, Ulf
>
> When I see log, I think the patch in attachment could fix this issue
> , but like I've not qcom board I can't test if it's fixed :-(.
>
> Ulf: for patch delivery, you prefer a patch delivery on mailing list ?

Thanks for looking into this.

However, no need to post a fix this time (your patch fixed the issue,
but should declare the qcom_variant_init() in mmci.h.

I have already amended the patch, so no further actions is needed.

[...]

Kind regards
Uffe
