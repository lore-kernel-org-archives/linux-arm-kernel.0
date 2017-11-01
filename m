From: stern@rowland.harvard.edu (Alan Stern)
Date: Wed, 1 Nov 2017 12:58:10 -0400 (EDT)
Subject: [PATCH v2 1/2] usb: ehci-platform: use reset array API
In-Reply-To: <1509552119-23816-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <Pine.LNX.4.44L0.1711011257190.1770-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2 Nov 2017, Masahiro Yamada wrote:

> Generic drivers like this need to control arbitrary number of reset
> lines.  Instead of hard-coding the maximum number of resets, use the
> reset array API.  It can manage a bunch of resets behind the scene.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
> Changes in v2:
>   - Goto err_put_clks when it fails to get reset_control.

For both 1/2 and 2/2:

Acked-by: Alan Stern <stern@rowland.harvard.edu>
