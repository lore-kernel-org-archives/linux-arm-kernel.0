From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 8 Jun 2018 10:06:26 +0200
Subject: [PATCH -next] pinctrl: mediatek: remove redundant return value
 check of platform_get_resource()
In-Reply-To: <1527766782-72315-1-git-send-email-weiyongjun1@huawei.com>
References: <1527766782-72315-1-git-send-email-weiyongjun1@huawei.com>
Message-ID: <CACRpkdY3YOAbsXHYu3m-0LUSf0FnXS6vO4+M3+=xUS_YuaydjQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 31, 2018 at 1:39 PM, Wei Yongjun <weiyongjun1@huawei.com> wrote:

> Remove unneeded error handling on the result of a call
> to platform_get_resource() when the value is passed to
> devm_ioremap_resource().
>
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>

Patch applied for fixes.

Yours,
Linus Walleij
