From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 15 Oct 2015 22:40:33 +0200
Subject: [PATCH] ARM: configs: Enable FIXED_PHY in multi_v7 defconfig
In-Reply-To: <1444926135-26513-1-git-send-email-maxime.coquelin@st.com>
References: <1444926135-26513-1-git-send-email-maxime.coquelin@st.com>
Message-ID: <5164143.2O3GLXJ4IB@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 15 October 2015 18:22:15 Maxime Coquelin wrote:
> CONFIG_FIXED_PHY is needed to have Ethernet working on STi boards.
> 
> Select it as built-in since RootFS is accessible from NFS on these boards.
> 
> Signed-off-by: Maxime Coquelin <maxime.coquelin@st.com>
> 

Applied to next/defconfig, thanks!

	Arnd
