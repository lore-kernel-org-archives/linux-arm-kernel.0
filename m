From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Wed, 30 May 2012 20:39:34 +0530
Subject: [RFC PATCH 3/3] arm: omap: phy: remove unused functions from
 omap-phy-internal.c
In-Reply-To: <1338388466-3565-4-git-send-email-kishon@ti.com>
References: <1338388466-3565-1-git-send-email-kishon@ti.com>
 <1338388466-3565-4-git-send-email-kishon@ti.com>
Message-ID: <CAMQu2gyK7MkwLUVmXWjgKLn+QPobEvz7bmLV+BituJkt1=qNmQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 30, 2012 at 8:04 PM, Kishon Vijay Abraham I <kishon@ti.com> wrote:
> All the unnessary functions in omap-phy-internal is removed.
> These functionality are now handled by omap-usb2 phy driver.
>
Cool. One less item in platform code.
