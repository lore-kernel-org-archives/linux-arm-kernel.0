From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 18 Aug 2017 23:08:07 +0200
Subject: [GIT PULL] Qualcomm ARM64 DT updates for 4.14 Part 2
In-Reply-To: <1503090124-1658-1-git-send-email-andy.gross@linaro.org>
References: <1503090124-1658-1-git-send-email-andy.gross@linaro.org>
Message-ID: <CAK8P3a3NhhFW_-7k3P6UUOG06EVhwwx503SPV9GJ1xf+Doh+bQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 18, 2017 at 11:02 PM, Andy Gross <andy.gross@linaro.org> wrote:
> The following changes since commit 6a6729f384365db9443a867bf8cf22255b3da582:
>
>   arm64: dts: qcom: msm8916: Add IOMMU support (2017-08-16 10:09:03 -0500)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/agross/linux.git tags/qcom-arm64-for-4.14-2
>
> for you to fetch changes up to 41dac73e243d42b89fd10dfd331824d4a39099ac:
>
>   arm64: dts: Add ipq8074 SoC and HK01 board support (2017-08-18 14:47:25 -0500)
>
> ----------------------------------------------------------------
> Qualcomm ARM64 Updates for v4.14 Part 2
>
> * Add IPQ8074 SoC and HK01 board support

Looks like everyone is updating their Wifi chips to 64-bit now, just merged
support for Mediatek mtk7622 as well.

Pulled into next/dt64, thanks!

        Arnd
