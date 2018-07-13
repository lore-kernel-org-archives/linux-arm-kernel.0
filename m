From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 13 Jul 2018 08:48:58 +0200
Subject: [PATCH -next] pinctrl: single: Fix missing unlock on error path
In-Reply-To: <1531312411-134133-1-git-send-email-weiyongjun1@huawei.com>
References: <1531312411-134133-1-git-send-email-weiyongjun1@huawei.com>
Message-ID: <CACRpkdaFmoqYO054CRaN0f_Dc9QiZ90Lx3hzVxndtfcJmZgi3w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 11, 2018 at 2:24 PM Wei Yongjun <weiyongjun1@huawei.com> wrote:

> Add the missing unlock before return from function
> in the error handling case.
>
> Fixes: 0f5972033509 ("pinctrl: single: Fix group and function selector use")
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>

Patch applied on top of fixes, for fixes!

Yours,
Linus Walleij
