From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Wed, 25 Apr 2018 17:07:28 +0200
Subject: [PATCH 0/2] can: flexcan: fix regression from v4.16-rc1
In-Reply-To: <20180425145040.22031-1-u.kleine-koenig@pengutronix.de>
References: <20180425145040.22031-1-u.kleine-koenig@pengutronix.de>
Message-ID: <0ab617ff-c650-b1f9-7fb4-8940fec42c07@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/25/2018 04:50 PM, Uwe Kleine-K?nig wrote:
> Hello,
> 
> when porting the kernel from a i.MX25 based machine to 4.17-rc1 (but
> still using the old dtb) can failed to probe. After some research we
> noticed that a commit that was merged in the v4.16 merge window
> introduced a change that broke using an older device tree.
> 
> This series first commit fixes the issue.
> The second patch introduces a fallback compatible which matches the
> usual dt-style on i.MX. (Before v4.16-rc1 there was a wrong fallback
> compatible that was removed.)

Applied both to linux-can + added stable on Cc.

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
Size: 488 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180425/e2d0e806/attachment-0001.sig>
