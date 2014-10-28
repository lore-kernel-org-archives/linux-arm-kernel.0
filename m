From: sre@kernel.org (Sebastian Reichel)
Date: Tue, 28 Oct 2014 03:18:35 +0100
Subject: [PATCH v2 5/8] power: reset: at91-reset: use at91_ramc_shutdown
In-Reply-To: <1414451377-11053-6-git-send-email-alexandre.belloni@free-electrons.com>
References: <1414451377-11053-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1414451377-11053-6-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <20141028021834.GA5739@earth.universe>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Oct 28, 2014 at 12:09:34AM +0100, Alexandre Belloni wrote:
> Now that all SoCs are registering the atmel-sdramc driver, use the
> at91_ramc_shutdown() function to shutdown the sdram.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

Acked-By: Sebastian Reichel <sre@kernel.org>

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141028/fadf2ed2/attachment.sig>
