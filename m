From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 5 Jul 2012 01:50:37 +0200
Subject: [PATCH] remoteproc: adopt the driver core's alloc/add/del/put
 naming
In-Reply-To: <1341409019-32166-1-git-send-email-ohad@wizery.com>
References: <1341409019-32166-1-git-send-email-ohad@wizery.com>
Message-ID: <CACRpkdYr4VFpSLhcy3vst4=ZzTVPG8OKiZvLb_z4VmKmJGrQeg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 4, 2012 at 3:36 PM, Ohad Ben-Cohen <ohad@wizery.com> wrote:

> To make remoteproc's API more intuitive for developers, we adopt
> the driver core's naming, i.e. alloc -> add -> del -> put. We'll also
> add register/unregister when their first user shows up.
>
> Otherwise - there's no functional change here.
>
> Suggested by Russell King <linux@arm.linux.org.uk>.
>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Stephen Boyd <sboyd@codeaurora.org>
> Cc: Fernando Guzman Lugo <fernando.lugo@ti.com>
> Cc: Sjur Br?ndeland <sjur.brandeland@stericsson.com>
> Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>

I understand this patch and it's a good thing, so:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
