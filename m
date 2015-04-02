From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 02 Apr 2015 16:25:09 +0200
Subject: [PATCH 4/6] ARM: dts: Add base DT for NXP LPC18xx and LPC4357
In-Reply-To: <1427923243-26296-5-git-send-email-manabian@gmail.com>
References: <1427923243-26296-1-git-send-email-manabian@gmail.com>
 <1427923243-26296-5-git-send-email-manabian@gmail.com>
Message-ID: <3163497.OVbqFkjUY9@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 01 April 2015 23:20:41 Joachim Eastwood wrote:
> +/ {
> +       aliases {
> +               serial0 = &uart0;
> +               serial1 = &uart1;
> +               serial2 = &uart2;
> +               serial3 = &uart3;
> +       };

Better move these to the board specific file.

	Arnd
