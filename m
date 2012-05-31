From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 31 May 2012 09:04:09 +0800
Subject: [RFC 19/34] dmaengine: PL08x: track mux usage on a per-channel
 basis.
In-Reply-To: <E1SZIvr-0006zy-Uk@rmk-PC.arm.linux.org.uk>
References: <20120529093015.GF12217@n2100.arm.linux.org.uk>
 <E1SZIvr-0006zy-Uk@rmk-PC.arm.linux.org.uk>
Message-ID: <CACRpkdboMbyU1jKCdoCvRruZfwSaakJ_goJ+BgGt0gi=3ThkNA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 29, 2012 at 5:41 PM, Russell King
<rmk+kernel@arm.linux.org.uk> wrote:

> Keep track of the number of descriptors currently using a MUX setting
> on a per-channel basis. ?This allows us to know when we have descriptors
> queued somewhere which have been assigned a DMA request signal.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
