From: stern@rowland.harvard.edu (Alan Stern)
Date: Fri, 7 Jun 2013 14:42:21 -0400 (EDT)
Subject: [RFC][PATCH 5/7] USB: OHCI: export ohci_hub_control and
 ohci_hub_status_data
In-Reply-To: <1370585013-12809-6-git-send-email-manjunath.goudar@linaro.org>
Message-ID: <Pine.LNX.4.44L0.1306071435010.1366-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 7 Jun 2013, Manjunath Goudar wrote:

> In order to make ohci-at91 and ohci-s3c2410 as a separate driver,
> ohci_hub_control and ohci_hub_status_data symbol needs to be exported.
> This work is part of enabling multi-platform kernels on ARM.

No, we are not going to export those two routines.  You can copy the 
approach used by Stephen Warren in the ehci-tegra conversion.

Alan Stern
