From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 25 Feb 2014 18:14:43 +0100
Subject: [GIT PULL] qcom driver changes for v3.15
In-Reply-To: <alpine.DEB.2.00.1402250926210.17163@galak-ubuntu.qualcomm.com>
References: <alpine.DEB.2.00.1402250926210.17163@galak-ubuntu.qualcomm.com>
Message-ID: <201402251814.43712.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 25 February 2014, Kumar Gala wrote:
> The following changes since commit cf1e8f0cd665e2a9966d2bee4e11ecc0938ff166:
> 
>    ARM: qcom: Rename various msm prefixed functions to qcom (2014-02-06 16:20:41 -0600)
> 
> are available in the git repository at:
> 
>    git://git.kernel.org/pub/scm/linux/kernel/git/galak/linux-qcom.git tags/qcom-drivers-for-3.15
> 
> for you to fetch changes up to add798a40aec3a768165055477ba8bfee21e06fc:
> 
>    gpio: msm: switch Kconfig to ARCH_QCOM depends (2014-02-25 09:22:10 -0600)
> 

Applied to the next/drivers branch now, and added a merge description
that I adapted from your patch changelogs:

    Merge "qcom driver changes for v3.15" from Kumar Gala:
    
    We've split Qualcomm MSM support into legacy and multiplatform.  These
    drivers are only relevant on the multiplatform supported SoCs so switch the
    Kconfig depends to ARCH_QCOM.
    
It would be helpful if you can in the future always add a description
yourself when creating the tag.

	Arnd
