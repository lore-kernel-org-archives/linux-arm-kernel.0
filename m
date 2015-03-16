From: timur@tabi.org (Timur Tabi)
Date: Mon, 16 Mar 2015 14:20:14 -0500
Subject: [PATCH 05/35 linux-next] tty: constify of_device_id array
In-Reply-To: <1426533469-25458-6-git-send-email-fabf@skynet.be>
References: <1426533469-25458-1-git-send-email-fabf@skynet.be>
 <1426533469-25458-6-git-send-email-fabf@skynet.be>
Message-ID: <55072CEE.7060103@tabi.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/16/2015 02:17 PM, Fabian Frederick wrote:
> of_device_id is always used as const.
> (See driver.of_match_table and open firmware functions)
>
> Signed-off-by: Fabian Frederick<fabf@skynet.be>

...

>   drivers/tty/serial/ucc_uart.c               | 2 +-

For this driver:

Acked-by: Timur Tabi <timur@tabi.org>
