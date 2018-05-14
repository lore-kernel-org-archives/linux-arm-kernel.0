From: olof@lixom.net (Olof Johansson)
Date: Mon, 14 May 2018 01:16:23 -0700
Subject: [PATCH] ARM: multi_v7_defconfig: Add STM32F7 I2C & STM32 USBPHYC
 support
In-Reply-To: <1525438015-15834-1-git-send-email-alexandre.torgue@st.com>
References: <1525438015-15834-1-git-send-email-alexandre.torgue@st.com>
Message-ID: <20180514081623.wdbtstz5kpfqk6ga@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 04, 2018 at 02:46:55PM +0200, Alexandre Torgue wrote:
> This patch adds STM32F7 I2C support to multi_v7_defconfig and
> enable the STM32 USB PHY Controller (USBPHYC) driver, implemented on
> STM32MP1 SoC.
> 
> Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
> Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
> Signed-off-by: Alexandre Torgue <alexandre.torgue@st.com>
> 
> ---
> 
> Hi Arnd, Kevin and Olof,
> 
> I just have this patch for STM32 configs update, so please consider it as my
> STM32 defconfig pull request for v4.18.

Applied, thanks!


-Olof
