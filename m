From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 31 May 2012 08:49:38 +0800
Subject: [RFC 07/34] dmaengine: PL08x: remove circular_buffer boolean from
 channel data
In-Reply-To: <E1SZIry-0006zA-K2@rmk-PC.arm.linux.org.uk>
References: <20120529093015.GF12217@n2100.arm.linux.org.uk>
 <E1SZIry-0006zA-K2@rmk-PC.arm.linux.org.uk>
Message-ID: <CACRpkdYv=LZgUegjo-4MuowTgUdMj7ZPn7TMGyagT45_Lovrnw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 29, 2012 at 5:37 PM, Russell King
<rmk+kernel@arm.linux.org.uk> wrote:

> Circular buffers are not handled in this way; we have a separate API
> call now to setup circular buffers. ?So lets not mislead people with
> this bool.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Acked-by: Linus Walleij <linus.walleij@linaro.org>
Yours,
Linus Walleij
