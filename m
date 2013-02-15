From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 15 Feb 2013 21:59:57 +0100
Subject: [PATCH] pinctrl: Declare operation structures as const
In-Reply-To: <1952247.y2EsDpZE5I@avalon>
References: <1360939402-1170-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <CACRpkdaN+j+cV-=d-cDSw6aoq4Hh0Ary8wpAeYQU7wvpTAQgcQ@mail.gmail.com>
 <1952247.y2EsDpZE5I@avalon>
Message-ID: <CACRpkdZCLqH7J9-mrjh4sBeKYD73nTrcFhbdZYjDbeJa1_Z7fg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 15, 2013 at 9:56 PM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:

> Hmmm... There's no pinconf_dbg_config_print() function in mainline. Where does
> it come from ?

The pinctrl devel branch I guess, soon to be shoveled into v3.9...
http://git.kernel.org/?p=linux/kernel/git/linusw/linux-pinctrl.git;a=shortlog;h=refs/heads/devel

Yours,
Linus Walleij
