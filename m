From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 02 Oct 2012 10:47:23 -0700
Subject: [PATCH] ARM: hw_breakpoint: Clear breakpoints before enabling
 monitor mode
In-Reply-To: <20121002091301.GA8847@mudshark.cambridge.arm.com>
References: <1348160260-19486-1-git-send-email-sboyd@codeaurora.org>
 <20120920173556.GQ4654@mudshark.cambridge.arm.com>
 <20120924171934.GE5522@mudshark.cambridge.arm.com>
 <506A3694.4070004@codeaurora.org>
 <20121002091301.GA8847@mudshark.cambridge.arm.com>
Message-ID: <506B28AB.4060706@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/02/12 02:13, Will Deacon wrote:
>
> Thanks Stephen. I've also got some patches for OS save/restore of the debug
> registers using the various hardware locking and readout mechanisms, so that
> debug state can be persisted across low-power states.
>
> Do any of the Qualcomm chips (v7 as opposed to v7.1) implement the save/restore
> registers?

Yes, we have save and restore registers.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
