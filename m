From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 20 Nov 2012 23:38:06 +0100
Subject: [PATCH 2/2] ARM: ux500: Move board specific GPIO info out to
 subordinate DTS files
In-Reply-To: <1352985288-29518-2-git-send-email-lee.jones@linaro.org>
References: <1352985288-29518-1-git-send-email-lee.jones@linaro.org>
 <1352985288-29518-2-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdZ+1dViNVXwLsNZG+iwgH0DkypuCmLJKZE0zsPcCXM42A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 15, 2012 at 2:14 PM, Lee Jones <lee.jones@linaro.org> wrote:

> GPIO numbers for the newly created gpio-regulator will differ from
> board to board. Therefore it's not sensible to leave this information
> in the top level DTSI file. Let's move them out to the DTS files
> where they can correctly vary.
>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
