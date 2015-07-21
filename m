From: danindrey@mail.ru (Andrey Danin)
Date: Tue, 21 Jul 2015 11:38:43 +0300
Subject: [PATCH v3 0/4] arm: tegra: implement NVEC driver using tegra i2c.
In-Reply-To: <1437424546-30405-1-git-send-email-danindrey@mail.ru>
References: <1437424546-30405-1-git-send-email-danindrey@mail.ru>
Message-ID: <55AE0513.6000108@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20.07.2015 23:35, Andrey Danin wrote:
> This version (v3) is for pushing tegra i2c driver to i2c tree.
> NVEC driver will be reworked later to use i2c core slave framework.
>
> NVEC driver contains code to manage tegra i2c controller in slave mode.
> I2C slave support was implemented in linux kernel. The goal of this
> patch serie is to implement I2C slave mode in tegra drived and rework
> NVEC driver to use it.
>
> Patches are based on i2c for-next.
>
> Changes for v3:
> - rebase on top of i2c for-next tree
> - fix 10-bit address condition in tegra i2c driver
>
Sorry, I didn't fix all comments in tegra i2c driver. I will send v4 soon.
