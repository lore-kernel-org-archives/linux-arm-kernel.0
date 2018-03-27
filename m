From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 27 Mar 2018 15:27:06 +0200
Subject: [GIT PULL] Qualcomm ARM64 Defconfig updates for 4.17
In-Reply-To: <1521512881-1854-1-git-send-email-andy.gross@linaro.org>
References: <1521512881-1854-1-git-send-email-andy.gross@linaro.org>
Message-ID: <CAK8P3a0bob7wU9W_zR_gfW11gjpsTvXQNcr30FbPavj+OgLjtw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 20, 2018 at 3:27 AM, Andy Gross <andy.gross@linaro.org> wrote:
> The following changes since commit 7928b2cbe55b2a410a0f5c1f154610059c57b1b2:
>
>   Linux 4.16-rc1 (2018-02-11 15:04:29 -0800)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/agross/linux.git tags/qcom-arm64-defconfig-for-4.17
>
> for you to fetch changes up to c1da37a3177366d565d16e03b89cf81d817c4689:
>
>   arm64: defconfig: enable more cpufreq governors (2018-03-08 18:45:02 -0600)
>
> ----------------------------------------------------------------
> Qualcomm ARM64 Based defconfig Updates for v4.17
>
> * Enable cpufreq governors, QCOM TSENS, and QCOM APCS driver
>
> ----------------------------------------------------------------
> Amit Kucheria (3):
>       arm64: defconfig: Enable the APCS IPC driver on Qualcomm platforms
>       arm64: defconfig: enable thermal sensor on QCOM platforms
>       arm64: defconfig: enable more cpufreq governors

Pulled into next/soc, thanks!

       Arnd
