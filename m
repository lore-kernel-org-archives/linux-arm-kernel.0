From: ranjit.waghmode@xilinx.com (Ranjit Abhimanyu Waghmode)
Date: Fri, 17 Jul 2015 12:03:48 +0000
Subject: [RFC PATCH 0/2] spi: add dual parallel & stacked mode support
 in Zynq MPSoC GQSPI controller
In-Reply-To: <20150716085739.GT11162@sirena.org.uk>
References: <1436445895-25504-1-git-send-email-ranjit.waghmode@xilinx.com>
 <20150714164005.GE11162@sirena.org.uk>
 <7CFCFE83B8145347A1D424EC939F1C3CA7E53D@XAP-PVEXMBX01.xlnx.xilinx.com>
 <20150715160146.GS11162@sirena.org.uk>
 <7CFCFE83B8145347A1D424EC939F1C3CA7E758@XAP-PVEXMBX01.xlnx.xilinx.com>
 <20150716085739.GT11162@sirena.org.uk>
Message-ID: <7CFCFE83B8145347A1D424EC939F1C3CA7F18F@XAP-PVEXMBX01.xlnx.xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

> -----Original Message-----
> From: Mark Brown [mailto:broonie at kernel.org]
> Sent: Thursday, July 16, 2015 2:28 PM
> To: Ranjit Abhimanyu Waghmode
> Cc: Michal Simek; Soren Brinkmann; dwmw2 at infradead.org;
> computersforpeace at gmail.com; zajec5 at gmail.com; marex at denx.de;
> shijie.huang at intel.com; juhosg at openwrt.org; ben at decadent.org.uk; linux-
> mtd at lists.infradead.org; linux-spi at vger.kernel.org; linux-arm-
> kernel at lists.infradead.org; linux-kernel at vger.kernel.org; Harini Katakam;
> Punnaiah Choudary Kalluri; ran27jit at gmail.com
> Subject: Re: [RFC PATCH 0/2] spi: add dual parallel & stacked mode support in
> Zynq MPSoC GQSPI controller
>
> On Thu, Jul 16, 2015 at 07:27:34AM +0000, Ranjit Abhimanyu Waghmode wrote:
>
> > For an example take two flashes connected in stacked mode.
> > For user it doesn't matter whether how many flashes are really connected.
> > There will be situation like, single partition is spread across two flashes
> (partition staring at the end of one flash and continued to the second flash). But
> it has to be shown contiguous to user.
> > In this scenario, I am not clear how MTD layer will handle the case.
> > It would be great if you could just put some light on it.
>
> That's something for the MTD layer or possibly even a layer above it to worry
> about - this situation is the same as we have with disks where we have md which
> combines other devices, if something similar is needed for flash we should use a
> similar pattern.

Kindly help in understanding, how can we represent the stacked mode and parallel mode changes in MTD layer?

Thanks & Regards,
Ranjit


This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.
