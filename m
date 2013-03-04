From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 4 Mar 2013 07:14:37 +0100
Subject: [PATCH] ARM: ux500: read the correct soc_id number
In-Reply-To: <1361348956-4387-1-git-send-email-fabio.baltieri@linaro.org>
References: <1361348956-4387-1-git-send-email-fabio.baltieri@linaro.org>
Message-ID: <CACRpkdbF0gjGt2BxzwAAxjWqGbybuzne+43vSKUiH_tqLQTFPQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 20, 2013 at 9:29 AM, Fabio Baltieri
<fabio.baltieri@linaro.org> wrote:

> Fix db8500_read_soc_id() to read all five soc_id number locations
> instead of repeating the second one two times.
>
> Signed-off-by: Fabio Baltieri <fabio.baltieri@linaro.org>

Thanks, patch applied!

Yours,
Linus Walleij
