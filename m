From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Tue, 3 Jan 2017 10:27:29 +0200
Subject: [PATCH 3/4] arm64: dts: exynos: make tm2 and tm2e independent
 from each other
In-Reply-To: <1483430237-26823-4-git-send-email-jcsing.lee@samsung.com>
References: <CGME20170103075734epcas5p43a9743131f63affd0a438d2ed342f22e@epcas5p4.samsung.com>
 <1483430237-26823-1-git-send-email-jcsing.lee@samsung.com>
 <1483430237-26823-4-git-send-email-jcsing.lee@samsung.com>
Message-ID: <CAJKOXPev9m07_dQWAvJ+=MKnbT0TFERKOtjWUDU+WXdGAiRyDA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 3, 2017 at 9:57 AM, Jaechul Lee <jcsing.lee@samsung.com> wrote:
> From: Andi Shyti <andi.shyti@samsung.com>
>
> Currently tm2e dts includes tm2 but there are some differences
> between the two boards and tm2 has some properties that tm2e
> doesn't have.
>
> That's why it's important to keep the two dts files independent
> and put all the commonalities in a tm2-common.dtsi file.
>
> Signed-off-by: Andi Shyti <andi.shyti@samsung.com>
> Signed-off-by: Jaechul Lee <jcsing.lee@samsung.com>
> ---
>  .../boot/dts/exynos/exynos5433-tm2-common.dtsi     | 1046 ++++++++++++++++++++
>  arch/arm64/boot/dts/exynos/exynos5433-tm2.dts      | 1033 +------------------
>  arch/arm64/boot/dts/exynos/exynos5433-tm2e.dts     |    2 +-
>  3 files changed, 1049 insertions(+), 1032 deletions(-)
>  create mode 100644 arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi

I would like to see here the rename and diff from it. Not entire delta
(deletions and addons). It is not possible to compare it... I think
git supports it by default with similarity of 50%.

Best regards,
Krzysztof
