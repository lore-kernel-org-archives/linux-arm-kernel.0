From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 11 Dec 2012 10:19:26 +0100
Subject: [PATCH 12/12] ARM: ux500: Remove traces of the ios_handler from
 platform code
In-Reply-To: <1355129761-8088-13-git-send-email-lee.jones@linaro.org>
References: <1355129761-8088-1-git-send-email-lee.jones@linaro.org>
 <1355129761-8088-13-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdazRYxuWustdd9TEYbu=ZipBO8ZsLnTDGTosWCPsPEgiw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 10, 2012 at 9:56 AM, Lee Jones <lee.jones@linaro.org> wrote:

> Now MMCI on/off functionality is using the regulator framework
> from the MMCI driver, there is no need to keep the ios_handler
> laying around, duplicating functionality. So we're removing it.
>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>
(Provided the rest is merged first.)

Yours,
Linus Walleij
