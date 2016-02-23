From: LW@KARO-electronics.de (Lothar =?UTF-8?B?V2HDn21hbm4=?=)
Date: Tue, 23 Feb 2016 11:15:59 +0100
Subject: [PATCH 2/9] spi: imx: initialize usedma earlier
In-Reply-To: <1456219438-21205-3-git-send-email-s.hauer@pengutronix.de>
References: <1456219438-21205-1-git-send-email-s.hauer@pengutronix.de>
 <1456219438-21205-3-git-send-email-s.hauer@pengutronix.de>
Message-ID: <20160223111559.3c2cb641@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, 23 Feb 2016 10:23:51 +0100 Sascha Hauer wrote:
> So that the SoC specific config function can know if we will do
> DMA or not. Will be needed in following patches.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
>
The first sentence of the commit log sounds silly unless you read it in
conjunction with the subject header. I made this remark already in
<20160219090846.3004de9d@ipc1.ka-ro>

Is there any reason why this commit log is written as a continuation of
the subject line (whithout making that obvious) while all the other
commit logs in your patch set are self-contained?


Lothar Wa?mann
