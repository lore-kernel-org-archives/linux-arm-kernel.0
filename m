From: cjb@laptop.org (Chris Ball)
Date: Tue, 02 Aug 2011 20:16:29 -0400
Subject: [PATCH v2 1/1] ARM: mxc: fix card interrupt losing issue on
	freescale eSDHC
In-Reply-To: <1311837360-16179-2-git-send-email-tony.lin@freescale.com> (Tony
	Lin's message of "Thu, 28 Jul 2011 15:16:00 +0800")
References: <1311837360-16179-1-git-send-email-tony.lin@freescale.com>
	<1311837360-16179-2-git-send-email-tony.lin@freescale.com>
Message-ID: <m2ty9z73j6.fsf@bob.laptop.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony,

On Thu, Jul 28 2011, Tony Lin wrote:
> apply workaround for imx eSDHC controller to avoid missing
> the card interrupt so that SDIO function is workable
>
> Signed-off-by: Tony Lin <tony.lin@freescale.com>

Thanks, pushed to mmc-next for 3.1.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
