From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 31 May 2012 09:25:24 +0800
Subject: [RFC 31/34] dmaengine: PL08x: fix tx_status function to return
 correct residue
In-Reply-To: <E1SZIzl-00070v-B1@rmk-PC.arm.linux.org.uk>
References: <20120529093015.GF12217@n2100.arm.linux.org.uk>
 <E1SZIzl-00070v-B1@rmk-PC.arm.linux.org.uk>
Message-ID: <CACRpkdYY+u6Ao-VP6q8OanXr=FxKbe35g4xMKHcqDw_enpYt5A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 29, 2012 at 5:45 PM, Russell King
<rmk+kernel@arm.linux.org.uk> wrote:

> Now that we're converted to use the generic vchan support, we can fix
> the residue return from tx_status to be compliant with dmaengine. ?This
> returns the number of bytes remaining for the _specified_ cookie, not
> the number of bytes in all pending transfers on the channel.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
