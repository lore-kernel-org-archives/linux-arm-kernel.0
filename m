From: appana.durga.rao@xilinx.com (Appana Durga Kedareswara Rao)
Date: Wed, 21 May 2014 11:32:41 +0000
Subject: [PATCH v8 2/2] can: xilinx CAN controller support.
In-Reply-To: <537C8E00.404@pengutronix.de>
References: <30fc07d6-4404-4745-8c03-1c5ae775e4f1@BY2FFO11FD047.protection.gbl>
 <537C8E00.404@pengutronix.de>
Message-ID: <72e9a444-0de4-42ce-a9d3-ee247948f0e6@BN1AFFO11FD030.protection.gbl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

        Yes for DT-bindings Rob already had given ack.
Sorry I forgot to add the Acked-by line in that patch.

Regards,
Kedar.

> -----Original Message-----
> From: Marc Kleine-Budde [mailto:mkl at pengutronix.de]
> Sent: Wednesday, May 21, 2014 4:59 PM
> To: Appana Durga Kedareswara Rao; wg at grandegger.com; Michal Simek;
> grant.likely at linaro.org; robh+dt at kernel.org
> Cc: linux-can at vger.kernel.org; netdev at vger.kernel.org; linux-arm-
> kernel at lists.infradead.org; linux-kernel at vger.kernel.org; Appana Durga
> Kedareswara Rao
> Subject: Re: [PATCH v8 2/2] can: xilinx CAN controller support.
>
> On 05/21/2014 09:00 AM, Kedareswara rao Appana wrote:
> > This patch adds xilinx CAN controller support.
> > This driver supports both ZYNQ CANPS and Soft IP AXI CAN controller.
> >
> > Signed-off-by: Kedareswara rao Appana <appanad@xilinx.com>
>
> Looks good, do you already have an Ack for the DT-bindings?
>
> Marc
>
> --
> Pengutronix e.K.                  | Marc Kleine-Budde           |
> Industrial Linux Solutions        | Phone: +49-231-2826-924     |
> Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
> Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |



This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.
