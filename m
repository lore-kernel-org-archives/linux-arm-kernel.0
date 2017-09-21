From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 21 Sep 2017 14:13:41 +0200
Subject: [PATCH v2 1/2] gpio: brcmstb: Handle return value of
 devm_kasprintf
In-Reply-To: <1cfed20c00d642a34d8f93c5e9591412d387fa2a.1505970542.git.arvind.yadav.cs@gmail.com>
References: <1cfed20c00d642a34d8f93c5e9591412d387fa2a.1505970542.git.arvind.yadav.cs@gmail.com>
Message-ID: <CACRpkdaXfVJrYcG12RPA-RHU+72X4quNOCL7M2Ppb-P8Tw=Pwg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 21, 2017 at 7:14 AM, Arvind Yadav <arvind.yadav.cs@gmail.com> wrote:

> devm_kasprintf() can fail here and we must check its return value.
>
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
> ---
> changes in v2 :
>                 Set return 'err' to -ENOMEM.

Patch applied.

Yours,
Linus Walleij
