From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 31 May 2012 09:11:56 +0800
Subject: [RFC 22/34] dmaengine: PL08x: remove waiting descriptor pointer
In-Reply-To: <E1SZIwq-00070A-AK@rmk-PC.arm.linux.org.uk>
References: <20120529093015.GF12217@n2100.arm.linux.org.uk>
 <E1SZIwq-00070A-AK@rmk-PC.arm.linux.org.uk>
Message-ID: <CACRpkdbSRUh4HArtNmak5ko1KhYz6rkVqbFyo0XBxsA_MdAoqg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 29, 2012 at 5:42 PM, Russell King
<rmk+kernel@arm.linux.org.uk> wrote:

> As we no longer need to pass a descriptor to prep_phy_channel(), we
> don't need to keep track of the descriptor which is waiting for a
> channel to become available. ?So let's get rid of it.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
