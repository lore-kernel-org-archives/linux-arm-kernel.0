From: nsekhar@ti.com (Nori, Sekhar)
Date: Tue, 1 Feb 2011 18:31:16 +0530
Subject: [PATCH 4/4] davinci: add spi devices support for
	da830/omap-l137/am17x evm
In-Reply-To: <4D47FFE1.6040901@criticallink.com>
References: <1296518716-5004-1-git-send-email-michael.williamson@criticallink.com>
	<1296518716-5004-5-git-send-email-michael.williamson@criticallink.com>
	<4D47F74B.9060309@mvista.com>
	<B85A65D85D7EB246BE421B3FB0FBB5930248777A33@dbde02.ent.ti.com>
	<4D47FFE1.6040901@criticallink.com>
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB5930248777A8F@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 01, 2011 at 18:13:13, Michael Williamson wrote:

> I need to move the da830evm_spi0_pdata structure into the common devices-da8xx.c
> based on your other comment to part 2/4 of this series.  
> 
> For my clarification on patch submission, do I need to change the authorship if
> I touch it in anyway?  Or should I leave you the author (given you ack the mods, 
> and confirm your sign-off)?

If you do not end up modifying the patch heavily, you can keep me
as the author.

In this case, the change you have done can be noted in between the
sign-offs. Thus:

Signed-off-by: Sekhar Nori <nsekhar@ti.com>
[michael.williamson at criticallink.com: moved da830evm_spi0_pdata to devices-da8xx.c]
Signed-off-by: Michael Williamson <michael.williamson@criticallink.com>

Thanks,
Sekhar
