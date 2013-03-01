From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 1 Mar 2013 13:39:39 +0100
Subject: [PATCH v2] pinctrl: Declare operation structures as const
In-Reply-To: <1361006707-28981-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1361006707-28981-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Message-ID: <CACRpkdZwWWsZEiKJBYPALzsVMEzZVCD+Ax2VNhp6yT223EFbQA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 16, 2013 at 10:25 AM, Laurent Pinchart
<laurent.pinchart+renesas@ideasonboard.com> wrote:

> The pinconf, pinctrl and pinmux operation structures hold function
> pointers that are never modified. Declare them as const.
>
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Patch applied!

Thanks,
Linus Walleij
