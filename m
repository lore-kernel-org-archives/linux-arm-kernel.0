From: khilman@linaro.org (Kevin Hilman)
Date: Thu, 17 Oct 2013 14:51:22 -0700
Subject: [GIT PULL] msm cleanups for v3.13
In-Reply-To: <1381954617-2431-1-git-send-email-davidb@codeaurora.org> (David
 Brown's message of "Wed, 16 Oct 2013 13:16:57 -0700")
References: <1381954617-2431-1-git-send-email-davidb@codeaurora.org>
Message-ID: <87fvrz1s85.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

David Brown <davidb@codeaurora.org> writes:

> The following changes since commit 4a10c2ac2f368583138b774ca41fac4207911983:
>
>   Linux 3.12-rc2 (2013-09-23 15:41:09 -0700)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/davidb/linux-msm.git tags/msm-cleanup-for-3.13
>
> for you to fetch changes up to 81cf1e061d001fab44dbaa85fc4fbfb6da6713a1:
>
>   ARM: msm: Rename msm devicetrees to have standard 'qcom' prefix (2013-09-25 13:02:56 -0700)
>
> ----------------------------------------------------------------
> General cleanups for MSM for 3.13
>
> Some small cleanups for MSM.  Removes extraneous irq definitions that
> aren't used on DT targets, moves the single existing board file to
> board-dt.c in antipication of additional targets, and renames the
> existing DT files to have a common 'qcom' prefix.
>
> ----------------------------------------------------------------

Pulled into next/cleanup,

Thanks,

Kevin
