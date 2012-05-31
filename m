From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 31 May 2012 09:11:22 +0800
Subject: [RFC 21/34] dmaengine: PL08x: move DMA signal muxing into slave
 prepare code
In-Reply-To: <E1SZIwW-000706-6T@rmk-PC.arm.linux.org.uk>
References: <20120529093015.GF12217@n2100.arm.linux.org.uk>
 <E1SZIwW-000706-6T@rmk-PC.arm.linux.org.uk>
Message-ID: <CACRpkdbT3L+mXc3WJG9NqhZRznnvD=5dSYkcgQCzUJiMXHZuhA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 29, 2012 at 5:42 PM, Russell King
<rmk+kernel@arm.linux.org.uk> wrote:

> Move the DMA request muxing into the slave prepare code and txd
> release/completion code. ?This means we only hold the DMA request
> mux while there are descriptors waiting to be started or are in
> progress.
>
> This leaves txd->direction as a write-only variable; remove it.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
