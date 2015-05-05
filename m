From: thierry.reding@gmail.com (Thierry Reding)
Date: Tue, 5 May 2015 16:42:36 +0200
Subject: [PATCH v8 0/9] Tegra xHCI support
In-Reply-To: <5548D389.2080609@nvidia.com>
References: <1430761002-9327-1-git-send-email-abrestic@chromium.org>
 <5548D389.2080609@nvidia.com>
Message-ID: <20150505144234.GA29813@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 05, 2015 at 03:28:25PM +0100, Jon Hunter wrote:
> Hi Andrew,
> 
> On 04/05/15 18:36, Andrew Bresticker wrote:
> > This series adds support for xHCI on NVIDIA Tegra SoCs.  This includes:
> >  - patches 1, 2, and 3: minor cleanups for mailbox framework and xHCI,
> >  - patches 4 and 5: adding an MFD driver for the XUSB cmoplex,
> >  - patches 6 and 7: adding a driver for the mailbox used to communicate
> >    with the xHCI controller's firmware, and
> >  - patches 8 and 9: adding a xHCI host-controller driver.
> > 
> > The addition of USB PHY support to the XUSB padctl driver has been dropped.
> > Thierry will be posting those patches later.
> > 
> > Given the many compile and run-time dependencies in this series, it is probably
> > best if the first 3 patches are picked up by the relevant maintainers in topic
> > branches so that the remainder of the series can go through the Tegra tree.
> > 
> > Tested on Jetson TK1 and Nyan-Big with a variety of USB2.0 and USB3.0 memory
> > sticks and ethernet dongles.  This has also been tested, with additional
> > out-of-tree patches, on Tegra132 and Tegra210 based boards.
> 
> For the series, you can add my ...
> 
> Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
> Tested-by: Jon Hunter <jonathanh@nvidia.com>
> 
> I have tested this on a t124 nyan-big with USB3.0 and USB2.0 devices.

How can this be tested without the corresponding USB PHY patches that
I'm supposed to be sending out?

Also, can anyone point me at patches that add the device tree nodes
which this driver makes use of?

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150505/38fc76be/attachment.sig>
