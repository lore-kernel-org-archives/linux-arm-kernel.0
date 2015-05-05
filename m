From: jonathanh@nvidia.com (Jon Hunter)
Date: Tue, 5 May 2015 15:28:25 +0100
Subject: [PATCH v8 0/9] Tegra xHCI support
In-Reply-To: <1430761002-9327-1-git-send-email-abrestic@chromium.org>
References: <1430761002-9327-1-git-send-email-abrestic@chromium.org>
Message-ID: <5548D389.2080609@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew,

On 04/05/15 18:36, Andrew Bresticker wrote:
> This series adds support for xHCI on NVIDIA Tegra SoCs.  This includes:
>  - patches 1, 2, and 3: minor cleanups for mailbox framework and xHCI,
>  - patches 4 and 5: adding an MFD driver for the XUSB cmoplex,
>  - patches 6 and 7: adding a driver for the mailbox used to communicate
>    with the xHCI controller's firmware, and
>  - patches 8 and 9: adding a xHCI host-controller driver.
> 
> The addition of USB PHY support to the XUSB padctl driver has been dropped.
> Thierry will be posting those patches later.
> 
> Given the many compile and run-time dependencies in this series, it is probably
> best if the first 3 patches are picked up by the relevant maintainers in topic
> branches so that the remainder of the series can go through the Tegra tree.
> 
> Tested on Jetson TK1 and Nyan-Big with a variety of USB2.0 and USB3.0 memory
> sticks and ethernet dongles.  This has also been tested, with additional
> out-of-tree patches, on Tegra132 and Tegra210 based boards.

For the series, you can add my ...

Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
Tested-by: Jon Hunter <jonathanh@nvidia.com>

I have tested this on a t124 nyan-big with USB3.0 and USB2.0 devices.

Cheers
Jon
