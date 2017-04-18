From: marc_gonzalez@sigmadesigns.com (Marc Gonzalez)
Date: Tue, 18 Apr 2017 11:27:05 +0200
Subject: [PATCH v2] serial: 8250_early: Add earlycon support for Palmchip
 UART
In-Reply-To: <7a016ff6-08fc-2811-92e0-7c4603fa8586@sigmadesigns.com>
References: <7a016ff6-08fc-2811-92e0-7c4603fa8586@sigmadesigns.com>
Message-ID: <65f27cfb-5f5a-e64c-7785-8ca71c02ea45@sigmadesigns.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[ Trimming CC list to minimize noise ]

On 10/04/2017 11:47, Marc Gonzalez wrote:

> Define an OF early console for Palmchip UART, which can be enabled
> by passing "earlycon" on the boot command line.
> 
> Signed-off-by: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
> ---
>  drivers/tty/serial/8250/8250_early.c | 24 ++++++++++++++++++++++++
>  drivers/tty/serial/8250/8250_port.c  |  4 ++--
>  2 files changed, 26 insertions(+), 2 deletions(-)

Hello Greg,

I'd really like to have earlycon support for this UART in v4.12

Do you see anything wrong with this patch, preventing it from landing?

Do you want me to move the function declarations to a header?
(If so, which one?)

Regards.
