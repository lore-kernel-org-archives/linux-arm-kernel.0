From: avictor.za@gmail.com (avictor.za at gmail.com)
Date: Mon, 6 Sep 2010 23:07:30 +0200
Subject: [PATCH] AT91: SAM9G45 - add a separate clock entry for every
	single TC block
In-Reply-To: <1283772201-15453-1-git-send-email-nicolas.ferre@atmel.com>
References: <201009060548.18521.fg@emlix.com>
	<1283772201-15453-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <AANLkTiny_0n3YT6+-GbpRzMcxBOF7x1P6b0Ynv_s3fR=@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Without this patch you will not be able to register the first block
> because of the second association call on at91_add_device_tc().
>
> Signed-off-by: Fabian Godehardt <fg@emlix.com>
> [nicolas.ferre at atmel.com: change tcb1_clk to fake child clock of tcb0_clk]
> Acked-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> Signed-off-by: Nicolas Ferre

Acked-By: Andrew Victor <linux@maxim.org.za>
