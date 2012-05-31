From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 31 May 2012 09:04:33 +0800
Subject: [RFC 20/34] dmaengine: PL08x: convert to a list of completed
 descriptors
In-Reply-To: <E1SZIwC-000702-2j@rmk-PC.arm.linux.org.uk>
References: <20120529093015.GF12217@n2100.arm.linux.org.uk>
 <E1SZIwC-000702-2j@rmk-PC.arm.linux.org.uk>
Message-ID: <CACRpkdZZZCTMzva1WfyqyJaN26=P_TQ9Nr6QSnzPMRFsFf5iAQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 29, 2012 at 5:42 PM, Russell King
<rmk+kernel@arm.linux.org.uk> wrote:

> Convert PL08x to use a list of completed descriptors rather than
> merely relying upon a single pointer. ?This makes it possible to
> schedule the tasklet for other purposes, and makes our behaviour
> similar to virt-dma.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
