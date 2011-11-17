From: khilman@ti.com (Kevin Hilman)
Date: Wed, 16 Nov 2011 16:06:08 -0800
Subject: [PATCH/RESEND #3 6/7] arm: omap: smartreflex: fix IRQ handling bug
In-Reply-To: <1321346765-16633-7-git-send-email-balbi@ti.com> (Felipe Balbi's
 message of "Tue, 15 Nov 2011 10:46:04 +0200")
References: <1321346765-16633-1-git-send-email-balbi@ti.com>
 <1321346765-16633-7-git-send-email-balbi@ti.com>
Message-ID: <87r51762a7.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Felipe Balbi <balbi@ti.com> writes:

F> fix a bug which has been on this driver since
> it was added by the original commit 984aa6db
> which would never clear IRQSTATUS bits.
>
> Signed-off-by: Felipe Balbi <balbi@ti.com>

Queuing this fix for v3.2-rc (branch: for_3.2/fixes/pm)

Kevin
