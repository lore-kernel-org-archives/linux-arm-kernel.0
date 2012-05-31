From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 31 May 2012 09:24:02 +0800
Subject: [RFC 28/34] dmaengine: PL08x: use vchan's spinlock
In-Reply-To: <E1SZIym-00070a-W5@rmk-PC.arm.linux.org.uk>
References: <20120529093015.GF12217@n2100.arm.linux.org.uk>
 <E1SZIym-00070a-W5@rmk-PC.arm.linux.org.uk>
Message-ID: <CACRpkdZZCnkKKqsYa105SAyvpm-A5df-ZLCr6jF0_ahdOb4O6A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 29, 2012 at 5:44 PM, Russell King
<rmk+kernel@arm.linux.org.uk> wrote:

> Initialize the vchan struct, and use the provided spinlock rather than
> our own.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
