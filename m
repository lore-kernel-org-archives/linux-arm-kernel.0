From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 11 Dec 2017 08:56:00 +0100
Subject: [PATCH 02/20] dt-bindings: gpio: Add ASPEED constants
In-Reply-To: <20171211050704.20621-3-joel@jms.id.au>
References: <20171211050704.20621-1-joel@jms.id.au>
 <20171211050704.20621-3-joel@jms.id.au>
Message-ID: <CAK8P3a17iWxJVv=f+=w+4sS7zWimxMSD5+Gz9qC5ms-RrcQneg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 11, 2017 at 6:06 AM, Joel Stanley <joel@jms.id.au> wrote:
> These are used to by the device tree to map pin numbers to constants
> required by the GPIO bindings.
> +
> +#define ASPEED_GPIO_PORT_A 0
> +#define ASPEED_GPIO_PORT_B 1
> +#define ASPEED_GPIO_PORT_C 2
> +#define ASPEED_GPIO_PORT_D 3
> +#define ASPEED_GPIO_PORT_E 4
> +#define ASPEED_GPIO_PORT_F 5
> +#define ASPEED_GPIO_PORT_G 6
> +#define ASPEED_GPIO_PORT_H 7
> +#define ASPEED_GPIO_PORT_I 8
> +#define ASPEED_GPIO_PORT_J 9
> +#define ASPEED_GPIO_PORT_K 10
> +#define ASPEED_GPIO_PORT_L 11
> +#define ASPEED_GPIO_PORT_M 12
> +#define ASPEED_GPIO_PORT_N 13
> +#define ASPEED_GPIO_PORT_O 14
> +#define ASPEED_GPIO_PORT_P 15
> +#define ASPEED_GPIO_PORT_Q 16
> +#define ASPEED_GPIO_PORT_R 17
> +#define ASPEED_GPIO_PORT_S 18
> +#define ASPEED_GPIO_PORT_T 19
> +#define ASPEED_GPIO_PORT_U 20
> +#define ASPEED_GPIO_PORT_V 21
> +#define ASPEED_GPIO_PORT_W 22
> +#define ASPEED_GPIO_PORT_X 23
> +#define ASPEED_GPIO_PORT_Y 24
> +#define ASPEED_GPIO_PORT_Z 25
> +#define ASPEED_GPIO_PORT_AA 26
> +#define ASPEED_GPIO_PORT_AB 27
> +#define ASPEED_GPIO_PORT_AC 28

This looks like a 1:1 mapping, wouldn't it be easier to just describe
it in the binding document?

    Arnd
