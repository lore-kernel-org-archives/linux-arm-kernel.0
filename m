From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 18 Aug 2014 11:30:03 -0600
Subject: [PATCH v2 0/9] Tegra xHCI support
In-Reply-To: <1408381705-3623-1-git-send-email-abrestic@chromium.org>
References: <1408381705-3623-1-git-send-email-abrestic@chromium.org>
Message-ID: <53F2381B.8020801@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/18/2014 11:08 AM, Andrew Bresticker wrote:
> This series adds support for xHCI on NVIDIA Tegra SoCs.  This includes:
>   - adding a driver for the mailbox used to communicate with the xHCI
>     controller's firmware,
>   - extending the XUSB pad controller driver to support the USB PHY
>     types (UTMI, HSIC, and USB3), and
>   - adding a xHCI host-controller driver.

Can you please remind us what dependencies exist between the patches? In 
other words, is it possible to apply parts of the series to their usual 
subsystem branches, or does the whole thing need to go into a single 
topic branch in order to avoid compile-time problems, or run-time 
problems in features unrelated to the new functionality? Thanks.
