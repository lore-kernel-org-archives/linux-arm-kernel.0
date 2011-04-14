From: davidb@codeaurora.org (David Brown)
Date: Thu, 14 Apr 2011 16:33:02 -0700
Subject: [PATCH V2 1/2] mtd: nand: Allow NAND chip ids to be included
	standalone.
In-Reply-To: <1299542935-20291-1-git-send-email-mnalajal@codeaurora.org>
	(Murali Nalajala's message of "Tue, 8 Mar 2011 05:38:55 +0530")
References: <1299542935-20291-1-git-send-email-mnalajal@codeaurora.org>
Message-ID: <8ya39lk5ryp.fsf@huya.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 07 2011, Murali Nalajala wrote:

> Lets non-standard NAND drivers take advantage of known NAND
> chip information.
>
> The initial development of msm nand driver, driver uses the supported
> NAND devices information as a hardcoded table. Remove the existing
> hardcoded supported flash device table and read the flash device
> information from the flash id table which are part of the mtd subsystem.
>
> Signed-off-by: Dima Zavin <dima@android.com>
> Signed-off-by: Murali Nalajala <mnalajal@codeaurora.org>

Acked-by: David Brown <davidb@codeaurora.org>

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
