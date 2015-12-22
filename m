From: olof@lixom.net (Olof Johansson)
Date: Tue, 22 Dec 2015 12:14:58 -0800
Subject: [GIT PULL] Qualcomm SoC Updates for 4.5
In-Reply-To: <1450384435-4300-1-git-send-email-andy.gross@linaro.org>
References: <1450384435-4300-1-git-send-email-andy.gross@linaro.org>
Message-ID: <20151222201458.GL30172@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 17, 2015 at 02:33:55PM -0600, Andy Gross wrote:
> The following changes since commit 8005c49d9aea74d382f474ce11afbbc7d7130bec:
> 
>   Linux 4.4-rc1 (2015-11-15 17:00:27 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/agross/linux.git tags/qcom-soc-for-4.5
> 
> for you to fetch changes up to bbeaa59598cae12626c9c42e91821e3abd5b87f0:
> 
>   MAINTAINERS: Change QCOM entries (2015-12-17 13:55:38 -0600)
> 
> ----------------------------------------------------------------
> Qualcomm ARM Based SoC Updates for 4.5
> 
> * Add WCNSS_CTRL client
> * Various Kconfig changes to fix build issues
> * Update SoC Qualcomm MAINTAINERS entry
> * Add SMP2P, SMSM, and SMEM state machine drivers
> * Add SMD-RPM support for existing platforms
> 
> ----------------------------------------------------------------
> Andy Gross (2):
>       soc: qcom: smd-rpm: Add existing platform support
>       MAINTAINERS: Change QCOM entries

Andy,

This patch dropped Kumar when it was posted on the list (and acked by
him), but doesn't now that it's applied. I've checked in a fix on top
of it to do so.


-Olof
