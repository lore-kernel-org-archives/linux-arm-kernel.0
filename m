From: maxime.coquelin@st.com (Maxime Coquelin)
Date: Tue, 3 Mar 2015 11:10:30 +0100
Subject: [PATCH 0/2] Enable DRM/KMS support for STiH407 and STiH410 boards
In-Reply-To: <1421250432-25903-1-git-send-email-gabriel.fernandez@linaro.org>
References: <1421250432-25903-1-git-send-email-gabriel.fernandez@linaro.org>
Message-ID: <54F58896.5010407@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 01/14/2015 04:47 PM, Gabriel FERNANDEZ wrote:
> This patch-set Enable DRM/KMS support for STiH407-b2120 and STiH410-b2120 boards.
>
> This patch-set replace the previous one (PATCH 0/2] Enable DRM/KMS support for STiH407 Family boards)
>
> Gabriel Fernandez (2):
>    ARM: DT: STiH407: Add DRM dt nodes
>    ARM: DT: STiH410: Add DRM dt nodes
>
>   arch/arm/boot/dts/stih407-b2120.dts  |   3 +-
>   arch/arm/boot/dts/stih407.dtsi       | 151 +++++++++++++++++++++++++++++++++++
>   arch/arm/boot/dts/stih410.dtsi       | 138 ++++++++++++++++++++++++++++++++
>   arch/arm/boot/dts/stihxxx-b2120.dtsi |   2 +-
>   4 files changed, 291 insertions(+), 3 deletions(-)
>   create mode 100644 arch/arm/boot/dts/stih407.dtsi
>
Forgot to reply to this series:

Applied, and already in v4.0-rc1.

Thanks,
Maxime
