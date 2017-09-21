From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 21 Sep 2017 14:14:38 +0200
Subject: [PATCH 2/2] gpio: tb10x: Handle return value of devm_kasprintf
In-Reply-To: <1505891589-6632-3-git-send-email-arvind.yadav.cs@gmail.com>
References: <1505891589-6632-1-git-send-email-arvind.yadav.cs@gmail.com>
 <1505891589-6632-3-git-send-email-arvind.yadav.cs@gmail.com>
Message-ID: <CACRpkdbWvi6La21jND3qy=h9fZMfr-d6ZY343ceTvNeD24D-Aw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 20, 2017 at 9:13 AM, Arvind Yadav <arvind.yadav.cs@gmail.com> wrote:

> devm_kasprintf() can fail here and we must check its return value.
>
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>

Patch applied.

Yours,
Linus Walleij
