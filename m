From: olof@lixom.net (Olof Johansson)
Date: Mon, 4 Jul 2016 22:35:25 -0700
Subject: [GIT PULL] Qualcomm Driver Updates for v4.8
In-Reply-To: <1467082363-22975-1-git-send-email-andy.gross@linaro.org>
References: <1467082363-22975-1-git-send-email-andy.gross@linaro.org>
Message-ID: <20160705053525.GS1669@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 27, 2016 at 09:52:43PM -0500, Andy Gross wrote:
> The following changes since commit 1a695a905c18548062509178b98bc91e67510864:
> 
>   Linux 4.7-rc1 (2016-05-29 09:29:24 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/agross/linux.git tags/qcom-drivers-for-4.8
> 
> for you to fetch changes up to dd4fe5b292226f2459305965c960d8dc39f36e0f:
> 
>   firmware: qcom: scm: Expose PAS command 10 as reset-controller (2016-06-24 22:53:52 -0500)
> 
> ----------------------------------------------------------------
> Qualcomm ARM Based Driver Updates for v4.8
> 
> * Rework of SCM driver
> * Add file patterns for Qualcomm Maintainers entry
> * Add worker for wcnss_ctrl signaling
> * Fixes for smp2p
> * Update smem_state properties to match documentation
> * Add SCM Peripheral Authentication service
> * Expose SCM PAS command 10 as a reset controller

Merged, thanks.


-Olof
