From: krohei@gmail.com (Heikki Krogerus)
Date: Thu, 8 Dec 2011 16:40:44 +0200
Subject: [PATCH] omap: rx51: initialize isp1704 properly
In-Reply-To: <1323287816-2809-1-git-send-email-felipe.contreras@gmail.com>
References: <20111207193141.GG31337@atomide.com>
 <1323287816-2809-1-git-send-email-felipe.contreras@gmail.com>
Message-ID: <20111208144044.GA25415@xps8300>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Felipe,

On Wed, Dec 07, 2011 at 09:56:56PM +0200, Felipe Contreras wrote:
> From: Heikki Krogerus <krohei@gmail.com>

I would prefer that you change this so this is from you, like it
actually is. You can mention me in the commit message if you like.

> Without this USB networking doesn't work as the link is never detected.

What this changes is, it leaves the transceiver powered by default
instead of setting it into power off mode. So not only USB networking
is affected by this. If isp1704_charger is not enabled with RX51, USB
does not work at all. Please change the comment.

Thanks,

-- 
heikki
