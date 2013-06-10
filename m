From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 10 Jun 2013 17:51:11 +0200
Subject: [PATCH 1/2] drivers: net: cpsw: use pinctrl PM helpers
In-Reply-To: <1370542515-22009-2-git-send-email-mugunthanvnm@ti.com>
References: <1370542515-22009-1-git-send-email-mugunthanvnm@ti.com>
 <1370542515-22009-2-git-send-email-mugunthanvnm@ti.com>
Message-ID: <CACRpkdbC0jRnJDSS-D04jw7QvOvSmwvnAb=NAAietMr3ZB86qQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 6, 2013 at 8:15 PM, Mugunthan V N <mugunthanvnm@ti.com> wrote:

> This utilize the new pinctrl core PM helpers to transition
> the driver to "default" and "sleep" states.
>
> Signed-off-by: Mugunthan V N <mugunthanvnm@ti.com>

This version of the patch applied with DaveM:s ACK.

Yours,
Linus Walleij
