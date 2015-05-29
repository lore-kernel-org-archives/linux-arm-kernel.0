From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 29 May 2015 14:03:28 +0200
Subject: [GIT PULL] qcom arm64 dt changes for 4.2
In-Reply-To: <alpine.DEB.2.02.1505261421580.24858@galak-ubuntu.qualcomm.com>
References: <alpine.DEB.2.02.1505261421580.24858@galak-ubuntu.qualcomm.com>
Message-ID: <2514993.QkiAKKlqnS@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 26 May 2015 14:23:24 Kumar Gala wrote:
> Qualcomm ARM64 Updates for v4.2
> 
> * Added SPMI PMIC Arbiter device tree node for MSM8916
> * Added 8x16 chipset SPMI PMIC's nodes
> * Added MSM8916 restart device node
> * Added initial set of PMIC and SoC pins for APQ8016 SBC board
> 

I've pulled this into next/dt as well, as we don't seem to have that
many arm64 changes this time.

Please continue sending the pull requests split between arm32 and arm64
like you did here though, to be on the safe side.

	Arnd
