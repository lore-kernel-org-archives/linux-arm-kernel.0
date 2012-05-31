From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 31 May 2012 09:23:13 +0800
Subject: [RFC 26/34] dmaengine: PL08x: rejig physical channel allocation
In-Reply-To: <E1SZIy8-00070S-Pg@rmk-PC.arm.linux.org.uk>
References: <20120529093015.GF12217@n2100.arm.linux.org.uk>
 <E1SZIy8-00070S-Pg@rmk-PC.arm.linux.org.uk>
Message-ID: <CACRpkdaGQEnQvhSFpmBKmE9dk1enCgJC6sf+Mj5dx8b_wv+_Ng@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 29, 2012 at 5:44 PM, Russell King
<rmk+kernel@arm.linux.org.uk> wrote:

> Rework the physical channel allocation mechanism to only allocate
> physical channels to virtual channels when they're about to be used.
> This eliminates all the complexity with holding channels while
> descriptors are being prepared, which is completely unnecessary.
>
> This also brings this driver to a state where the generic virtual DMA
> code can be used with this driver, and opens up the possibility of
> properly scheduling and prioritorising physical DMA channels to
> virtual DMA channels.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
