From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 10 Aug 2016 15:02:05 +0200
Subject: [PATCH 0244/1285] Replace numeric parameter like 0444 with macro
In-Reply-To: <20160802105246.30008-1-baolex.ni@intel.com>
References: <20160802105246.30008-1-baolex.ni@intel.com>
Message-ID: <CACRpkdZsgSfL9rwe-vU5S6nNy0weD3O3PZymUZQsvJhQTSjf=w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 2, 2016 at 12:52 PM, Baole Ni <baolex.ni@intel.com> wrote:

> I find that the developers often just specified the numeric value
> when calling a macro which is defined with a parameter for access permission.
> As we know, these numeric value for access permission have had the corresponding macro,
> and that using macro can improve the robustness and readability of the code,
> thus, I suggest replacing the numeric parameter with the macro.
>
> Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
> Signed-off-by: Baole Ni <baolex.ni@intel.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

I assume Wolfram will merge this.

Yours,
Linus Walleij
