From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 7 Apr 2015 23:29:01 +0200
Subject: [PATCH 3.18-stable v2] ARM: mvebu: do not register custom DMA
 operations when coherency is disabled
In-Reply-To: <20150407231638.0993cb16@free-electrons.com>
References: <1426157892-1705-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20150407231638.0993cb16@free-electrons.com>
Message-ID: <20150407212901.GB21006@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 07, 2015 at 11:16:38PM +0200, Thomas Petazzoni wrote:
> Hello,
> 
> Any reason why this patch hasn't been included in 3.18-stable? It is
> a very important patch fixing a major regression. What needs to be done
> to get it merged in 3.18 ?

Hi Thomas

It looks to have the right tags, so you should probably take it up
with the 3.18 maintainer, Sasha Levin.

     Andrew
