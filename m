From: linus.walleij@linaro.org (Linus Walleij)
Date: Sat, 24 Nov 2018 21:44:41 +0100
Subject: [PATCH 3/9] drm: replace "drm_dev_unref" function with
 "drm_dev_put"
In-Reply-To: <20181115221634.22715-4-greenfoo@gluegarage.com>
References: <20181115221634.22715-1-greenfoo@gluegarage.com>
 <20181115221634.22715-4-greenfoo@gluegarage.com>
Message-ID: <CACRpkdatws8igmhXrEZSi6+ZES+omtWDone8SjpUrN9pohBNGw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 15, 2018 at 11:17 PM Fernando Ramos <greenfoo@gluegarage.com> wrote:

> This patch unifies the naming of DRM functions for reference counting as
> requested on Documentation/gpu/todo.rst
>
> Signed-off-by: Fernando Ramos <greenfoo@gluegarage.com>

Patch applied after some collecting ACKs and tweaking.

Yours,
Linus Walleij
