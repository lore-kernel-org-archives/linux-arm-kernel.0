From: cbouatmailru@gmail.com (Anton Vorontsov)
Date: Fri, 25 Nov 2011 02:22:46 +0400
Subject: [PATCH] ARM: sa1100: collie: Remove irq_to_gpio from power driver
In-Reply-To: <1321727197-26686-1-git-send-email-jochen@scram.de>
References: <1321727197-26686-1-git-send-email-jochen@scram.de>
Message-ID: <20111124222246.GA19585@oksana.dev.rtsoft.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 19, 2011 at 07:26:37PM +0100, Jochen Friedrich wrote:
> Since 9d08d5d77a355510c2f5657c86b0a4b25acfe72c, irq_to_gpio() is no
> longer available but still in use by collie_battery.c. As it's just
> for a debug message, just get rid of this call.
> 
> Signed-off-by: Jochen Friedrich <jochen@scram.de>
> ---

Applied to battery-urgent.git, thanks!

-- 
Anton Vorontsov
Email: cbouatmailru at gmail.com
