From: timur@codeaurora.org (Timur Tabi)
Date: Tue, 9 May 2017 09:12:41 -0500
Subject: [PATCH 1/9] [v3] arm64: defconfig: resynchronize the defconfig
In-Reply-To: <1493828280-6620-2-git-send-email-timur@codeaurora.org>
References: <1493828280-6620-1-git-send-email-timur@codeaurora.org>
 <1493828280-6620-2-git-send-email-timur@codeaurora.org>
Message-ID: <a92fa867-d9ec-f209-ed75-1e1c9cb28308@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/03/2017 11:17 AM, Timur Tabi wrote:
> Defconfig files become unsynchronized over time as Kconfig entries are
> added, removed, or changed.  Making specific changes to the defconfig
> becomes difficult as unrelated differences can interfere.  This problem
> is easily remedied:
> 
> 	make defconfig
> 	make savedefconfig
> 	cp defconfig arch/arm64/configs/defconfig
> 	git add arch/arm64/configs/defconfig
> 	git commit -s <sha>
> 
> Signed-off-by: Timur Tabi <timur@codeaurora.org>

At the very least, could SOMEONE please clean up the defconfig in time for
4.12, so that future merges are easier?  Like I said earlier, it's very much
out of sync.

I will re-sumbit my defconfig changes for 4.13, but it would be a lot easier
for me to do so if the defconfig is in sync by then.

Thanks.

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc.  Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
