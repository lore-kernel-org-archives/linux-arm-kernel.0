From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 14 Mar 2017 16:22:54 +0100
Subject: [PATCH v3 2/6] iio: trigger: add OF support
In-Reply-To: <1488300679-3259-3-git-send-email-fabrice.gasnier@st.com>
References: <1488300679-3259-1-git-send-email-fabrice.gasnier@st.com>
 <1488300679-3259-3-git-send-email-fabrice.gasnier@st.com>
Message-ID: <CACRpkdY9Xh8+Fe61ZQf6pa_ptNVaXj7DeTgtat4ZRNs3qzyGVA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 28, 2017 at 5:51 PM, Fabrice Gasnier <fabrice.gasnier@st.com> wrote:

> Provide OF support. Device drivers can get IIO triggers from dt.
> Introduce IIO trigger specifiers, so there are:
> - IIO trigger providers, e.g. dt nodes designated with
>   #io-trigger-cells=<num of cells>
> - IIO trigger consumers, e.g. phandles listed in io-triggers = <...>.
>   Those can be identified by names by using 'io-trigger-names'.
>
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

This is very elegant.

Yours,
Linus Walleij
