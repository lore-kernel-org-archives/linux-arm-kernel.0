From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Thu, 17 Jan 2013 17:12:52 +0400
Subject: [PATCH] usb: musb: ux500: use clk_prepare_enable and
 clk_disable_unprepare
In-Reply-To: <CACRpkdbmgQ0xDfkbgqc=zDqMDUK0O6uQOf3kX9v1+=+N5s42bw@mail.gmail.com>
References: <1357577261-31536-1-git-send-email-fabio.baltieri@linaro.org>
 <CACRpkdZD1i_tvDf6XFyk5muYjtDziQaMNGK6vvihhFJVztXUjw@mail.gmail.com>
 <20130110133818.GA22710@balto.lan>
 <CACRpkdbmgQ0xDfkbgqc=zDqMDUK0O6uQOf3kX9v1+=+N5s42bw@mail.gmail.com>
Message-ID: <50F7F8D4.90207@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 17-01-2013 14:46, Linus Walleij wrote:

>>> <fabio.baltieri@linaro.org> wrote:

>>>> This patch converts the module to use clk_prepare_enable and
>>>> clk_disable_unprepare variants as required by common clock framework.

>>>> Without this the system crash during probe function.

>>>> Signed-off-by: Fabio Baltieri <fabio.baltieri@linaro.org>

>>> Acked-by: Linus Walleij <linus.walleij@linaro.org>

>> Thanks for the ACK.  This bug was here unnoticed since 3.6 merge window,

> Then it should have Cc: stable at kernel.org..

    The new address is stable at vger.kernel.org.

WBR, Sergei
