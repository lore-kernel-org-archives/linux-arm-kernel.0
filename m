From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 29 Apr 2014 13:16:28 +0200
Subject: [PATCH v4 2/5] ARM: dts: Add support for DRA72x family of devices
In-Reply-To: <1398769513-8736-3-git-send-email-rnayak@ti.com>
References: <1398769513-8736-1-git-send-email-rnayak@ti.com>
 <1398769513-8736-3-git-send-email-rnayak@ti.com>
Message-ID: <5062004.uhiBYDX4C3@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 29 April 2014 16:35:10 Rajendra Nayak wrote:
> DRA722 is part of DRA72x family which are single core cortex A15 devices
> with most infrastructure IPs otherwise same as whats on the DRA74x family.
> 
> So move the cpu nodes into dra74x.dtsi and dra72x.dtsi respectively.
> 
> Also add a minimal dra72-evm dts file.
> 
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> Cc: linux-doc at vger.kernel.org
> Cc: devicetree at vger.kernel.org

Acked-by: Arnd Bergmann <arnd@arndb.de>
