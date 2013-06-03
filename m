From: paul@pwsan.com (Paul Walmsley)
Date: Mon, 3 Jun 2013 09:24:29 +0000 (UTC)
Subject: [PATCH] arm: omap2: fix AM33xx hwmod infos for UART2
In-Reply-To: <1369754265-27712-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1369754265-27712-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <alpine.DEB.2.02.1306030924130.4635@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 28 May 2013, Thomas Petazzoni wrote:

> The UART2 hwmod structure is pointing to the EDMA channels of UART1,
> which doesn't look right. This patch fixes this by making the UART2
> hwmod structure to a new structure that lists the EDMA channels to be
> used by the UART2.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Thanks Thomas, queued with Vaibhav's ack.


- Paul
