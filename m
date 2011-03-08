From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Tue, 08 Mar 2011 09:50:22 +0200
Subject: [PATCH V2 1/2] mtd: nand: Allow NAND chip ids to be included
	standalone.
In-Reply-To: <1299542935-20291-1-git-send-email-mnalajal@codeaurora.org>
References: <1299542935-20291-1-git-send-email-mnalajal@codeaurora.org>
Message-ID: <1299570622.2754.4.camel@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2011-03-08 at 05:38 +0530, Murali Nalajala wrote:
> Lets non-standard NAND drivers take advantage of known NAND
> chip information.
> 
> The initial development of msm nand driver, driver uses the supported
> NAND devices information as a hardcoded table. Remove the existing
> hardcoded supported flash device table and read the flash device
> information from the flash id table which are part of the mtd subsystem.

Why this initial version should be upstream? Why wouldn't you make it
"standard" first?

-- 
Best Regards,
Artem Bityutskiy (????? ????????)
