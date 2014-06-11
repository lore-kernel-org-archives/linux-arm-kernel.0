From: antoine.tenart@free-electrons.com (Antoine =?iso-8859-1?Q?T=E9nart?=)
Date: Wed, 11 Jun 2014 10:36:30 +0200
Subject: [PATCH v5 0/7] ARM: berlin: add AHCI support
In-Reply-To: <1401115908-2742-1-git-send-email-antoine.tenart@free-electrons.com>
References: <1401115908-2742-1-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <20140611083630.GA32216@kwain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

On Mon, May 26, 2014 at 04:51:41PM +0200, Antoine T?nart wrote:
> This series adds the support for Berlin SoC AHCI controller. The
> controller allows to use the SATA host interface and, for example, the
> eSATA port on the BG2Q.
> 
> The series adds a PHY driver to control the two SATA ports available,
> and adds a generic compatible to use the existing ahci_platform driver.
> 
> Also enable the eSATA interface on the BG2Q DMP.

Any news on this series?


Antoine

-- 
Antoine T?nart, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
