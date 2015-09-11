From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 11 Sep 2015 19:10:29 +0100
Subject: [GIT PULL] qcom fixes for 4.3-rc1
In-Reply-To: <1441994854-32163-1-git-send-email-agross@codeaurora.org>
References: <1441994854-32163-1-git-send-email-agross@codeaurora.org>
Message-ID: <20150911181029.GB21084@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Kevin, Olof,

Please hold off on this until the comments I made on the patch in this
pull request, which was only posted 15 minutes prior to this pull
request, have been discussed.

Thanks.

On Fri, Sep 11, 2015 at 01:07:33PM -0500, Andy Gross wrote:
> The following changes since commit bc0195aad0daa2ad5b0d76cce22b167bc3435590:
> 
>   Linux 4.2-rc2 (2015-07-12 15:10:30 -0700)
> 
> are available in the git repository at:
> 
>   git at git.codeaurora.org:quic/kernel/agross-msm.git tags/qcom-fixes-for-4.3-rc1
> 
> for you to fetch changes up to 100dea902f73d8658655f59b4021cbc3c6c3c957:
> 
>   firmware: qcom: scm: Add function stubs for ARM64 (2015-09-11 11:59:31 -0500)
> 
> ----------------------------------------------------------------
> Qualcomm fixes for v4.3-rc1
> 
> * Add SCM function call stubs on ARM64
> 
> ----------------------------------------------------------------
> Andy Gross (1):
>       firmware: qcom: scm: Add function stubs for ARM64
> 
>  drivers/firmware/Makefile      |    4 +++
>  drivers/firmware/qcom_scm-64.c |   63 ++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 67 insertions(+)
>  create mode 100644 drivers/firmware/qcom_scm-64.c

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
