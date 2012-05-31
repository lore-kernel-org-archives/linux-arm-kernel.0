From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 31 May 2012 08:54:28 +0800
Subject: [RFC 09/34] dmaengine: PL08x: move private data structures into
 amba-pl08x.c
In-Reply-To: <E1SZIsc-0006zJ-R0@rmk-PC.arm.linux.org.uk>
References: <20120529093015.GF12217@n2100.arm.linux.org.uk>
 <E1SZIsc-0006zJ-R0@rmk-PC.arm.linux.org.uk>
Message-ID: <CACRpkdaZrFvkiaUzC+Mza+9R2vD2iyHFPjrYCswB6pVGwccjAg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 29, 2012 at 5:38 PM, Russell King
<rmk+kernel@arm.linux.org.uk> wrote:

> Move the driver private data structures into the driver itself, rather
> than having them exposed to everyone in a header file.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
