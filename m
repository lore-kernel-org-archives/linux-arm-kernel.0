From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 2 Oct 2017 22:38:31 +0200
Subject: [PATCH v3 04/12] pinctrl: axp209: add programmable
 gpio_status_offset
In-Reply-To: <20171002120854.5212-5-quentin.schulz@free-electrons.com>
References: <20171002120854.5212-1-quentin.schulz@free-electrons.com>
 <20171002120854.5212-5-quentin.schulz@free-electrons.com>
Message-ID: <20171002203831.rvf7g7nzg2wacrve@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 02, 2017 at 12:08:46PM +0000, Quentin Schulz wrote:
> To prepare for patches that will add support for a new PMIC that has a
> different GPIO input status register, add a gpio_status_offset within
> axp20x_pctl structure and use it.
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171002/1b2e7486/attachment-0001.sig>
