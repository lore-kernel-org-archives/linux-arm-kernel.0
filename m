From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Tue, 15 May 2012 10:58:39 +0100
Subject: [PATCH 7/8] arm: mach-armada: add defconfig
In-Reply-To: <1337072084-21967-8-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1337072084-21967-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1337072084-21967-8-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <4FB228CF.9040508@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15/05/12 09:54, Thomas Petazzoni wrote:
> From: Gregory CLEMENT<gregory.clement@free-electrons.com>
>
> Signed-off-by: Gregory CLEMENT<gregory.clement@free-electrons.com>
> Signed-off-by: Thomas Petazzoni<thomas.petazzoni@free-electrons.com>
> Signed-off-by: Lior Amsalem<alior@marvell.com>
> ---
>   arch/arm/configs/armada_defconfig |   47 +++++++++++++++++++++++++++++++++++++
>   1 file changed, 47 insertions(+)
>   create mode 100644 arch/arm/configs/armada_defconfig
>
> diff --git a/arch/arm/configs/armada_defconfig b/arch/arm/configs/armada_defconfig
> new file mode 100644

personally, I'd go for armadaxp_defconfig.

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
