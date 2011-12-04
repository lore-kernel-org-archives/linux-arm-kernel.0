From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Sun, 04 Dec 2011 16:15:02 +0400
Subject: [PATCH] arm, da8xx, mmc: set second MMC controllers default queue
In-Reply-To: <1322991210-20486-1-git-send-email-hs@denx.de>
References: <1322991210-20486-1-git-send-email-hs@denx.de>
Message-ID: <4EDB6446.2010208@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 04-12-2011 13:33, Heiko Schocher wrote:

> The MMC driver allocates channels with EVENTQ_DEFAULT they

    Missed comma before "they"?

> get put into EVENTQ_1 which the second EDMA controller does
> not have and hence transfers stall. This is tried to fix
> in commit f23fe857bbea393b4b94fe2218c98d934bd3d4cf

    Please also specify that commit's summary in parens.

> from Ido Yariv, but missed a fix for the second MMC
> controller on da850.

> Signed-off-by: Heiko Schocher<hs@denx.de>
> Signed-off-by: juha.kuikka at gmail.com
> Reported-by: juha.kuikka at gmail.com
> Cc: linux-mmc at vger.kernel.org
> Cc: davinci-linux-open-source at linux.davincidsp.com
> Cc: Rajashekhara, Sudhakar<sudhakar.raj@ti.com>
> Cc: Ido Yariv<ido@wizery.com>
> Cc: Sekhar Nori<nsekhar@ti.com>
> Cc: Wolfgang Denk<wd@denx.de>

WBR, Sergei
