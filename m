From: eric@eukrea.com (=?UTF-8?B?RXJpYyBCw6luYXJk?=)
Date: Fri, 08 Oct 2010 10:27:30 +0200
Subject: [PATCH] mxc_udc: add workaround for ENGcm09152 for i.MX35
In-Reply-To: <1286196058-2395-1-git-send-email-eric@eukrea.com>
References: <1286196058-2395-1-git-send-email-eric@eukrea.com>
Message-ID: <4CAED5F2.6050400@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sascha, Hi Dinh,

Le 04/10/2010 14:40, Eric B?nard a ?crit :
> this patch gives the possibility to workaround bug ENGcm09152
> on i.MX35 when the hardware workaround is also implemented on
> the board.
>
Do you have any feedback on this patch ?
It covers the workaround described on page 25 of the following Errata :
http://cache.freescale.com/files/dsp/doc/errata/IMX35CE.pdf

Thanks
Eric
