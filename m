From: balbi@ti.com (Felipe Balbi)
Date: Thu, 17 Nov 2011 09:08:38 +0200
Subject: [PATCH/RESEND #3 6/7] arm: omap: smartreflex: fix IRQ handling bug
In-Reply-To: <87r51762a7.fsf@ti.com>
References: <1321346765-16633-1-git-send-email-balbi@ti.com>
 <1321346765-16633-7-git-send-email-balbi@ti.com>
 <87r51762a7.fsf@ti.com>
Message-ID: <20111117070836.GA30936@legolas.emea.dhcp.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 16, 2011 at 04:06:08PM -0800, Kevin Hilman wrote:
> Felipe Balbi <balbi@ti.com> writes:
> 
> F> fix a bug which has been on this driver since
> > it was added by the original commit 984aa6db
> > which would never clear IRQSTATUS bits.
> >
> > Signed-off-by: Felipe Balbi <balbi@ti.com>
> 
> Queuing this fix for v3.2-rc (branch: for_3.2/fixes/pm)

should it go to stable too ??

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20111117/340ef8ba/attachment.sig>
