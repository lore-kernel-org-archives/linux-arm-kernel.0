From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 31 May 2012 09:25:52 +0800
Subject: [RFC 32/34] dmaengine: PL08x: get rid of
 pl08x_prep_channel_resources
In-Reply-To: <E1SZJ05-00070z-Eq@rmk-PC.arm.linux.org.uk>
References: <20120529093015.GF12217@n2100.arm.linux.org.uk>
 <E1SZJ05-00070z-Eq@rmk-PC.arm.linux.org.uk>
Message-ID: <CACRpkdbRNNr7yFTOt4Vt5RA1nY4PyrNnJPAT+GxwDTmRv-wHng@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 29, 2012 at 5:46 PM, Russell King
<rmk+kernel@arm.linux.org.uk> wrote:

> This function is now unnecessary; we can move its internals inline
> instead.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
