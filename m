From: jaswinder.singh@linaro.org (Jassi Brar)
Date: Tue, 25 Nov 2014 19:02:22 +0530
Subject: [PATCH V6 00/12] Tegra xHCI support
In-Reply-To: <1416874644-12070-1-git-send-email-abrestic@chromium.org>
References: <1416874644-12070-1-git-send-email-abrestic@chromium.org>
Message-ID: <CAJe_Zhcz=WOLy0_98xRj6=i2+5MFeXQGPmYJhnpy1NfUEPJ-0w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25 November 2014 at 05:47, Andrew Bresticker <abrestic@chromium.org> wrote:
> This series adds support for xHCI on NVIDIA Tegra SoCs.  This includes:
>  - patches 1, 2, and 3: minor cleanups for mailbox framework and xHCI,
>  - patches 4 and 5: adding a driver for the mailbox used to communicate
>    with the xHCI controller's firmware,
>  - patches 6 and 7: extending the XUSB pad controller driver to support
>    the USB PHY types (UTMI, HSIC, and USB3),
>  - patches 8 and 9: adding a xHCI host-controller driver, and
>  - patches 10, 11, and 12: updating the relevant DT files.
>
> The mailbox driver (patch 5) has a compile-time dependency on patch 2 and
> a run-time dependency on patch 3.  Both the PHY (patch 7) and host (patch 9)
> drivers have compile-time dependencies on the mailbox driver.  The host
> driver also has a run-time dependency on patch 1.  Because of this, this
> entire series should probably go through the Tegra tree.
>
Why shouldn't I pick 2 & 3 at least?

-Jassi
