From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Wed, 28 Jan 2015 15:46:05 +0100
Subject: [PATCH v5] can: Convert to runtime_pm
In-Reply-To: <baf987c11c0242c2bf87b81f9396b09d@BN1BFFO11FD018.protection.gbl>
References: <baf987c11c0242c2bf87b81f9396b09d@BN1BFFO11FD018.protection.gbl>
Message-ID: <54C8F62D.6090909@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/12/2015 04:04 PM, Kedareswara rao Appana wrote:
> Instead of enabling/disabling clocks at several locations in the driver,
> Use the runtime_pm framework. This consolidates the actions for runtime PM
> In the appropriate callbacks and makes the driver more readable and mantainable.
> 
> Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
> Signed-off-by: Kedareswara rao Appana <appanad@xilinx.com>
> ---
> Changes for v5:
>  - Updated with the review comments.
>    Updated the remove fuction to use runtime_pm.
> Chnages for v4:
>  - Updated with the review comments.
> Changes for v3:
>   - Converted the driver to use runtime_pm.
> Changes for v2:
>   - Removed the struct platform_device* from suspend/resume
>     as suggest by Lothar.

Any plans to submit a v6?

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
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150128/93040070/attachment-0001.sig>
