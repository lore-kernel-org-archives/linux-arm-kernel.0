From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 14 Feb 2014 11:41:45 +0100
Subject: [PATCH 2/9] ARM: select HAVE_SMP for V7 multi-platform
In-Reply-To: <1392153119-23248-3-git-send-email-robherring2@gmail.com>
References: <1392153119-23248-1-git-send-email-robherring2@gmail.com>
 <1392153119-23248-3-git-send-email-robherring2@gmail.com>
Message-ID: <CACRpkdb8das0-rQPwQBM2omAh+=gVn=_HkySQS0rdkR+OxnqmQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 11, 2014 at 10:11 PM, Rob Herring <robherring2@gmail.com> wrote:

> From: Rob Herring <robh@kernel.org>
>
> All V7 platforms can run SMP kernels, so make CONFIG_SMP visible for V7
> multi-platform builds.
>
> Signed-off-by: Rob Herring <robh@kernel.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
