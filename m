From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 26 Oct 2012 09:16:50 +0200
Subject: [PATCH] GPIO: clps711x: Fix direction logic for PORTD
In-Reply-To: <1351067686-19344-1-git-send-email-shc_work@mail.ru>
References: <1351067686-19344-1-git-send-email-shc_work@mail.ru>
Message-ID: <CACRpkda0uAwTgeJ7p8GtzVRVsoRbduXZzdbGTrOOqWANp2tHHA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 24, 2012 at 10:34 AM, Alexander Shiyan <shc_work@mail.ru> wrote:

> PORTD have different direction logic, i.e. "0" is output and "1" is input.
> This patch fix this issue.
>
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>

Thanks Alexander, patch applied.

Yours,
Linus Walleij
