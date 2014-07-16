From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Wed, 16 Jul 2014 12:05:05 +0200
Subject: [PATCH v5 1/2] can: m_can: add device tree binding documentation
In-Reply-To: <1405503050-16796-1-git-send-email-b29396@freescale.com>
References: <1405503050-16796-1-git-send-email-b29396@freescale.com>
Message-ID: <53C64E51.9050606@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/16/2014 11:30 AM, Dong Aisheng wrote:
> add M_CAN device tree binding documentation
> 
> Cc: Wolfgang Grandegger <wg@grandegger.com>
> Cc: Marc Kleine-Budde <mkl@pengutronix.de>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Oliver Hartkopp <socketcan@hartkopp.net>
> Cc: Varka Bhadram <varkabhadram@gmail.com>
> Signed-off-by: Dong Aisheng <b29396@freescale.com>
> ---
> Changes since v4:
> - change the name of board dtsi to board dts which is more common
> 
> Changes since v3:
> - change mram-cfg property name to bosch,mram-cfg
> - indent change
> ---
>  .../devicetree/bindings/net/can/m_can.txt          |   67 ++++++++++++++++++++
>  1 files changed, 67 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/net/can/m_can.txt

I'll apply this series once we've got an Ack for the DT folks.

Marc

-- 
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 242 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140716/409130c2/attachment-0001.sig>
