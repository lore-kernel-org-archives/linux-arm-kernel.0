From: antoine.tenart@free-electrons.com (Antoine =?iso-8859-1?Q?T=E9nart?=)
Date: Wed, 23 Apr 2014 10:58:02 +0200
Subject: [PATCH 5/6] ARM: berlin: add the AHCI node for the BG2
In-Reply-To: <20140423104539.37c9366f@xhacker>
References: <1398181105-19714-1-git-send-email-antoine.tenart@free-electrons.com>
 <1398181105-19714-6-git-send-email-antoine.tenart@free-electrons.com>
 <20140423104539.37c9366f@xhacker>
Message-ID: <20140423085802.GF24355@kwain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jisheng,

On Wed, Apr 23, 2014 at 10:45:39AM +0800, Jisheng Zhang wrote:
> On Tue, 22 Apr 2014 08:38:24 -0700
> Antoine T?nart <antoine.tenart@free-electrons.com> wrote:
> 
> > The BG2 has an AHCI SATA controller. Add the corresponding node
> > in its device tree.
> 
> The AHCI IP of BG2 is different with BG2Q, so the driver in the series of patch
> doesn't work on BG2.

Thanks for the info! I'll drop BG2 and BG2CD nodes in the v2.

Antoine

-- 
Antoine T?nart, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
