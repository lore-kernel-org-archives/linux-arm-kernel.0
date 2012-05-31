From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 31 May 2012 09:00:09 +0800
Subject: [RFC 14/34] dmaengine: PL08x: extract function to to generate
 cctl values
In-Reply-To: <E1SZIuF-0006zd-D0@rmk-PC.arm.linux.org.uk>
References: <20120529093015.GF12217@n2100.arm.linux.org.uk>
 <E1SZIuF-0006zd-D0@rmk-PC.arm.linux.org.uk>
Message-ID: <CACRpkdZyzjcMefZZVzo_1e6Bmus5+UVzcf8VR3iXinmODUzvUQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 29, 2012 at 5:39 PM, Russell King
<rmk+kernel@arm.linux.org.uk> wrote:

> Extract the functionality from dma_slave_config to generate the cctl
> values for a given bus width and burst size. ?This allows us to use
> this elsewhere in the driver, namely the prepare functions.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
