From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 5 Jan 2018 12:23:49 +0100
Subject: [GIT PULL] Qualcomm Driver updates for 4.16 - Redo
In-Reply-To: <1515097934-13713-1-git-send-email-andy.gross@linaro.org>
References: <1515097934-13713-1-git-send-email-andy.gross@linaro.org>
Message-ID: <CAK8P3a0gKeMttEHKPVNCTw09vH8gmsRG_QQMJm6++g1Hy4915Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 4, 2018 at 9:32 PM, Andy Gross <andy.gross@linaro.org> wrote:
> The following changes since commit 4fbd8d194f06c8a3fd2af1ce560ddb31f7ec8323:
>
>   Linux 4.15-rc1 (2017-11-26 16:01:47 -0800)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/agross/linux.git tags/qcom-drivers-for-4.16
>
> for you to fetch changes up to 3aa0582fdb824139630298880fbf78d4ac774d3c:
>
>   of: platform: populate /firmware/ node from of_platform_default_populate_init() (2018-01-04 14:00:20 -0600)
>
> ----------------------------------------------------------------
> Qualcomm ARM Based Driver Updates for v4.16 - Redo
>
> * Fix error handling code in SMP2P probe
> * Update SMP2P to use ACPS as mailbox client
> * Add QMI support
> * Fixups for Qualcomm SCM
> * Fix licensing on rmtfs_mem
> * Correct SMSM child node lookup
> * Populate firmware nodes during platform init

Pulled into next/drivers, thanks!

        Arnd
