From: pawel.moll@arm.com (Pawel Moll)
Date: Thu, 11 Jun 2015 15:23:45 +0100
Subject: [PATCH v2] arm64: dts: add device tree for ARM SMM-A53x2 on
 LogicTile Express 20MG
In-Reply-To: <1434032317-8033-1-git-send-email-kristina.martsenko@arm.com>
References: <1434032317-8033-1-git-send-email-kristina.martsenko@arm.com>
Message-ID: <1434032625.3418.100.camel@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2015-06-11 at 15:18 +0100, Kristina Martsenko wrote:
>  - Remove enable-method and cpu-release-addr from the second CPU (since the
>    Boot Monitor can add those itself).
> 
> +/* In use by spinning secondaries */
> +/memreserve/ 0x80000000 0x00010000;

... and so it does with memreserve on cpu-release-addr.

Pawel
