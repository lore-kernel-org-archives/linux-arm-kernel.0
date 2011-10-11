From: sshtylyov@ru.mvista.com (Sergei Shtylyov)
Date: Tue, 11 Oct 2011 15:23:52 +0400
Subject: [RFT/PATCH 6/7] arm: omap: smartreflex: fix IRQ handling bug
In-Reply-To: <1318249579-4089-6-git-send-email-balbi@ti.com>
References: <1318249579-4089-1-git-send-email-balbi@ti.com>
	<1318249579-4089-6-git-send-email-balbi@ti.com>
Message-ID: <4E942748.80901@ru.mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 10-10-2011 16:26, Felipe Balbi wrote:

> fix a bug which has been on this driver since
> it was added by the original commit 984aa6db

    Please also specify that commit's summary in parens.

> which would never clear IRQSTATUS bits.

> Signed-off-by: Felipe Balbi <balbi@ti.com>

WBR, Sergei
