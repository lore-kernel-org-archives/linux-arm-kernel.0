From: dgilbert@interlog.com (Douglas Gilbert)
Date: Wed, 30 Jan 2013 09:48:23 +0100
Subject: [PATCH] ARM: at91: at91sam9x5.dtsi:usart3 TXD
In-Reply-To: <51083A70.1070809@interlog.com>
References: <51083A70.1070809@interlog.com>
Message-ID: <5108DE57.4090905@interlog.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13-01-29 10:09 PM, Douglas Gilbert wrote:
> Comment for usart3 TXD (TXD3) is correct, dt code is wrong.
>
> The patch is against lk 3.8.0-rc5 .

Actually this patch also depends on a patch by Robert Nelson
titled: "[PATCH] ARM: at91: at91sam9x5: fix usart3 pinctrl name"
posted on Monday 28 January, 2013. Two separate bugs in
3 lines of code, not bad going :-)

Doug Gilbert
