From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 31 May 2012 09:24:39 +0800
Subject: [RFC 30/34] dmaengine: PL08x: convert to use vchan done list
In-Reply-To: <E1SZIzR-00070l-78@rmk-PC.arm.linux.org.uk>
References: <20120529093015.GF12217@n2100.arm.linux.org.uk>
 <E1SZIzR-00070l-78@rmk-PC.arm.linux.org.uk>
Message-ID: <CACRpkdY0scgLt=q9nh-B6ugZF6WqPQ_3VezxcByXQ1rF3nbcTw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 29, 2012 at 5:45 PM, Russell King
<rmk+kernel@arm.linux.org.uk> wrote:

> Convert to use the virtual dma channel done list, tasklet, and
> descriptor freeing.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
