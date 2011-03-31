From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Thu, 31 Mar 2011 12:54:02 +0300
Subject: [PATCH 3/7] add the database for the NANDs
In-Reply-To: <1300240521-4344-4-git-send-email-b32955@freescale.com>
References: <1300240521-4344-1-git-send-email-b32955@freescale.com>
	<1300240521-4344-4-git-send-email-b32955@freescale.com>
Message-ID: <1301565242.2828.32.camel@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2011-03-16 at 09:55 +0800, Huang Shijie wrote:
> This is a database for the NANDs which is now supported by imx23 and imx28.
> 
> Signed-off-by: Huang Shijie <b32955@freescale.com>

I agree GPMI is a great and powerful controller. But it is not the only
cotroller out there, and we obviously should not have NAND device data
bases for each nice NAND controller, righ? So we obviously have to have
only one single data-base.

-- 
Best Regards,
Artem Bityutskiy (????? ????????)
