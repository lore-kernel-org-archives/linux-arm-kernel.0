From: jszhang@marvell.com (Jisheng Zhang)
Date: Wed, 23 Apr 2014 10:45:39 +0800
Subject: [PATCH 5/6] ARM: berlin: add the AHCI node for the BG2
In-Reply-To: <1398181105-19714-6-git-send-email-antoine.tenart@free-electrons.com>
References: <1398181105-19714-1-git-send-email-antoine.tenart@free-electrons.com>
 <1398181105-19714-6-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <20140423104539.37c9366f@xhacker>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Antoine

On Tue, 22 Apr 2014 08:38:24 -0700
Antoine T?nart <antoine.tenart@free-electrons.com> wrote:

> The BG2 has an AHCI SATA controller. Add the corresponding node
> in its device tree.

The AHCI IP of BG2 is different with BG2Q, so the driver in the series of patch
doesn't work on BG2.

Thanks
