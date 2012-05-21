From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 21 May 2012 20:50:15 +0200
Subject: [PATCH 1/6] DMA: PL08x: move private data structures into
 amba-pl08x.c
In-Reply-To: <E1SUc2Z-0001md-KT@rmk-PC.arm.linux.org.uk>
References: <20120516110451.GA9571@n2100.arm.linux.org.uk>
 <E1SUc2Z-0001md-KT@rmk-PC.arm.linux.org.uk>
Message-ID: <CACRpkdayz0BHZhfTP5931YcNDnttVjKKa=a6f8gyR8Ph23j22A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 16, 2012 at 1:05 PM, Russell King
<rmk+kernel@arm.linux.org.uk> wrote:

> Move the driver private data structures into the driver itself, rather
> than having them exposed to everyone in a header file.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

I applied this series (it needed a trvial fix for the Nomadik variant support
which is in Vinod's tree), then ran memcpy tests on the NHK S8815,
and it works like a charm.

So FWIW:
Tested-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
