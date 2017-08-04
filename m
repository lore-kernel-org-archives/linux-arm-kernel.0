From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 4 Aug 2017 13:03:48 +0200
Subject: [GIT PULL] Qualcomm ARM64 defconfig fixes for v4.13-rc2
In-Reply-To: <1501216532-31021-1-git-send-email-andy.gross@linaro.org>
References: <1501216532-31021-1-git-send-email-andy.gross@linaro.org>
Message-ID: <CAK8P3a15B2Z-B--kRsXKBGN86mi9uq70BsWk5vzwV6kG-ESEKw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 28, 2017 at 6:35 AM, Andy Gross <andy.gross@linaro.org> wrote:
> Arnd, Olof, and Kevin,
>
> Recent changes to the hwspinlock Kconfig changed the behavior for enabling
> the hwspinlock driver.  This patch fixes the defconfig to make the current
> hwspinlock selections work as they did before the changes for QCOM platforms.

Pulled into fixes, thanks!

       arnd
