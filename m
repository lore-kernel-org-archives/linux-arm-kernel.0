From: davidb@codeaurora.org (David Brown)
Date: Tue, 9 Aug 2011 15:26:04 -0700
Subject: [RFC PATCH 5/8] ARM: msm: convert logical CPU numbers to
	physical numbers
In-Reply-To: <1312926162-22469-6-git-send-email-will.deacon@arm.com>
References: <1312926162-22469-1-git-send-email-will.deacon@arm.com>
	<1312926162-22469-6-git-send-email-will.deacon@arm.com>
Message-ID: <20110809222604.GA15160@huya.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 09, 2011 at 10:42:39PM +0100, Will Deacon wrote:
> This patch uses the new cpu_logical_map() macro for converting logical
> CPU numbers into physical numbers when dealing with the pen_release
> variable in the SMP boot and CPU hotplug paths.
> 
> Cc: David Brown <davidb@codeaurora.org>
> Signed-off-by: Will Deacon <will.deacon@arm.com>

For MSM8660:

Tested-by: David Brown <davidb@codeaurora.org>
Acked-by: David Brown <davidb@codeaurora.org>

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
