From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Sun, 19 Sep 2010 15:51:47 +0400
Subject: [PATCH] ARM: make app read out process num even not use SMP
In-Reply-To: <1284866536-21431-1-git-send-email-leiwen@marvell.com>
References: <1284866536-21431-1-git-send-email-leiwen@marvell.com>
Message-ID: <4C95F953.9020807@ru.mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 19-09-2010 7:22, Lei Wen wrote:

> Some app like trace-cmd need to know the process number, but not
> all arm board is enabled with the SMP. Add this fix up to let those
> app works happy.

> Signed-off-by: Lei Wen<leiwen@marvell.com>
> Signed-off-by: Lei Wen<leiwen@marvell.com>

    One signoff is enough. :-)

WBR, Sergei
