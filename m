From: davidb@codeaurora.org (David Brown)
Date: Wed, 7 Aug 2013 15:14:16 -0700
Subject: [GIT PULL] msm cleanups for v3.12
In-Reply-To: <20130807215259.GA22852@codeaurora.org>
References: <1375909096-22088-1-git-send-email-davidb@codeaurora.org>
 <20130807215259.GA22852@codeaurora.org>
Message-ID: <20130807221416.GA23229@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 07, 2013 at 02:52:59PM -0700, David Brown wrote:
>On Wed, Aug 07, 2013 at 01:58:16PM -0700, David Brown wrote:
>>The following changes since commit 3b2f64d00c46e1e4e9bd0bb9bb12619adac27a4b:
>>
>>  Linux 3.11-rc2 (2013-07-21 12:05:29 -0700)
>>
>>are available in the git repository at:
>>
>>  git://git.kernel.org/pub/scm/linux/kernel/git/davidb/linux-msm.git for-3.12/msm-cleanup2
>>
>>for you to fetch changes up to b80a0dc53df68c6862b8985ecc12856edb080248:
>>
>>  ARM: msm: fix compilation error in gpiomux (2013-08-07 10:39:31 -0700)
>
>Sigh, it looks like this fixes code that was removed in last-week's
>fix patches.  I can either regenerate the pull request, or feel free
>to "resolve" this by just using the removal of the code.

Sorry, this patch doesn't actually conflict with the fixes, but is
incorrect in light of them.  I will resend the pull request without
this patch.

David

-- 
sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
