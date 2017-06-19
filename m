From: olof@lixom.net (Olof Johansson)
Date: Sun, 18 Jun 2017 22:37:07 -0700
Subject: [GIT PULL] Qualcomm Driver updates for 4.13
In-Reply-To: <1497383309-14226-4-git-send-email-andy.gross@linaro.org>
References: <1497383309-14226-1-git-send-email-andy.gross@linaro.org>
 <1497383309-14226-4-git-send-email-andy.gross@linaro.org>
Message-ID: <20170619053707.GC7703@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andy,

On Tue, Jun 13, 2017 at 03:48:27PM -0400, Andy Gross wrote:
> The following changes since commit 2ea659a9ef488125eb46da6eb571de5eae5c43f6:
> 
>   Linux 4.12-rc1 (2017-05-13 13:19:49 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/agross/linux.git tags/qcom-drivers-for-4.13
> 
> for you to fetch changes up to d4348b43bbcadb6d5faee36024245944b6600d25:
> 
>   firmware: qcom_scm: Fix to allow COMPILE_TEST-ing (2017-06-09 16:15:10 -0500)
> 
> ----------------------------------------------------------------
> Qualcomm ARM Based Driver Updates for v4.13
> 
> * Fix COMPILE_TEST flag for QCOM SCM
> * Improve QCOM SMSM error handling
> 
> ----------------------------------------------------------------
> Jonathan Neusch??fer (1):
>       soc: qcom: smsm: Improve error handling, quiesce probe deferral
> 
> Stanimir Varbanov (1):
>       firmware: qcom_scm: Fix to allow COMPILE_TEST-ing

This patch doesn't seem like it's doing the right thing -- I've replied to it
on the list with comments.

Not merged. Let me know if you want me to cherry-pick the other patch (or send
a new pull request with just that one).


-Olof
