From: martinwguy@gmail.com (Martin Guy)
Date: Sun, 9 May 2010 17:57:19 +0100
Subject: [PATCH v7 2/2] ep93xx: SPI driver platform support code
In-Reply-To: <c4be393041bfab8d1c27d43dd5a2526222d1d4ef.1273120206.git.mika.westerberg@iki.fi>
References: <cover.1273120206.git.mika.westerberg@iki.fi>
	<c4be393041bfab8d1c27d43dd5a2526222d1d4ef.1273120206.git.mika.westerberg@iki.fi>
Message-ID: <AANLkTikVbmYVjTcSGl72bBKRBlXoGF5KGRveuUInov-0@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5/6/10, Mika Westerberg <mika.westerberg@iki.fi> wrote:
> This patch adds platform side support code for the EP93xx SPI driver. This
>  includes clock, resources and muxing. There is a new function: ep93xx_register_spi()
>  which can be used by board support code to register new SPI devices for the
>  board.
>
>  Signed-off-by: Mika Westerberg <mika.westerberg@iki.fi>
>  Acked-by: H Hartley Sweeten <hsweeten@visionengravers.com>

Acked-by: Martin Guy <martinwguy@gmail.com>
