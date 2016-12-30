From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 30 Dec 2016 14:30:47 +0100
Subject: [PATCH v2 2/4] pinctrl: dt-bindings: samsung: add drive strength
 macros for Exynos5433
In-Reply-To: <20161230041421.24448-3-andi.shyti@samsung.com>
References: <CGME20161230041427epcas1p1e4d0dd5e7f9928664c664b7850dbd87a@epcas1p1.samsung.com>
 <20161230041421.24448-1-andi.shyti@samsung.com>
 <20161230041421.24448-3-andi.shyti@samsung.com>
Message-ID: <CACRpkdaE0-4MN+D1THxo7nqQ5qMNZOi7b+cpqE+6-x8RFPuUfA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 30, 2016 at 5:14 AM, Andi Shyti <andi.shyti@samsung.com> wrote:

> Commit 5db7e3bb87df ("pinctrl: dt-bindings: samsung: Add header with
> values used for configuration") has added a header file for defining the
> pinctrl values in order to avoid hardcoded settings in the Exynos
> DTS related files.
>
> Extend samsung.h to the Exynos5433 for drive strength values
> which are strictly related to the particular SoC and may defer
> from others.
>
> Signed-off-by: Andi Shyti <andi.shyti@samsung.com>

Patch applied with Chanwoo's review tag.

Yours,
Linus Walleij
