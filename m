From: timur@codeaurora.org (Timur Tabi)
Date: Wed, 3 May 2017 10:53:41 -0500
Subject: [PATCH 0/9] [v3] arm64: defconfig: enable several options useful
 for ARM64 server platforms
In-Reply-To: <20170503154852.GS8233@arm.com>
References: <1493413563-18375-1-git-send-email-timur@codeaurora.org>
 <20170503154852.GS8233@arm.com>
Message-ID: <49cef082-f1e7-a790-0a9c-9f0c9fe12d4a@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/03/2017 10:48 AM, Will Deacon wrote:
> The arm-soc folks usually deal with defconfig updates, so please resend this
> to arm at kernel.org, although I suspect it's too late for 4.12 given that the
> merge window is now open. The "resynchronize" patch is also likely to
> conflict with any other pending changes to the file.

I'm sure it will conflict, but the defconfig has to be synchronized sooner
or later.  Frankly, I think Linus should just do a "batch resynchronize" of
every defconfig in every release (e.g. make it the last commit).
arch/arm64/configs/defconfig is way off today, and it's only going to get worse.

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc.  Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
