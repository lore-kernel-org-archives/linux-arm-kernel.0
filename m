From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 21 Apr 2016 10:25:07 +0200
Subject: [PATCH v2 08/11] arm/dts: Add Aspeed ast2400 device tree
In-Reply-To: <1461225849-28074-9-git-send-email-joel@jms.id.au>
References: <1461225849-28074-1-git-send-email-joel@jms.id.au>
 <1461225849-28074-9-git-send-email-joel@jms.id.au>
Message-ID: <4396654.23ARpFjP0v@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 21 April 2016 17:34:06 Joel Stanley wrote:
> +
> +       aliases {
> +               serial0 = &uart1;
> +               serial1 = &uart2;
> +               serial2 = &uart3;
> +               serial3 = &uart4;
> +               serial4 = &uart5;
> +               serial5 = &uart6;
> +       };
> +
> 

Can you put the aliases into the dts files instead and list only
the ones that are connected?

	Arnd
