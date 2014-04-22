From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 22 Apr 2014 13:48:33 +0200
Subject: [PATCH v3 6/7] pinctrl: sunxi: add reset control support
In-Reply-To: <1397137966-30818-7-git-send-email-boris.brezillon@free-electrons.com>
References: <1397137966-30818-1-git-send-email-boris.brezillon@free-electrons.com>
 <1397137966-30818-7-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <CACRpkdaedD0n4dD3tnz5HxrZVUUfYo7cwmjrs4grQJ-2+P+RZw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 10, 2014 at 3:52 PM, Boris BREZILLON
<boris.brezillon@free-electrons.com> wrote:

> The A31 SoC define a reset line for the R_PIO block which needs to be
> deasserted.
>
> Try to retrieve a reset control and deassert if one was found.
>
> Signed-off-by: Boris BREZILLON <boris.brezillon@free-electrons.com>

Patch applied with Maxime's ACK.

Yours,
Linus Walleij
