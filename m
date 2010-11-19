From: balbi@ti.com (Felipe Balbi)
Date: Fri, 19 Nov 2010 10:34:07 +0200
Subject: [PATCH v3 4/5] OMAP: mailbox: send message in process context
In-Reply-To: <1290107742-16760-5-git-send-email-h-kanigeri2@ti.com>
References: <1290107742-16760-1-git-send-email-h-kanigeri2@ti.com>
	<1290107742-16760-5-git-send-email-h-kanigeri2@ti.com>
Message-ID: <20101119083407.GJ6446@legolas.emea.dhcp.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Nov 18, 2010 at 01:15:41PM -0600, Hari Kanigeri wrote:
>Schedule the Tasklet to send only when mailbox fifo is full and there are
>pending messages in kifo, else send the message directly in the Process
		     ^kfifo

-- 
balbi
