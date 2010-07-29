From: Joerg.Roedel@amd.com (Roedel, Joerg)
Date: Thu, 29 Jul 2010 11:28:21 +0200
Subject: [PATCH 1/2] arm: msm: Add System MMU support.
In-Reply-To: <20100729181412H.fujita.tomonori@lab.ntt.co.jp>
References: <20100729084018.GM26098@amd.com>
	<20100729174621W.fujita.tomonori@lab.ntt.co.jp>
	<20100729090607.GN26098@amd.com>
	<20100729181412H.fujita.tomonori@lab.ntt.co.jp>
Message-ID: <20100729092821.GP26098@amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 29, 2010 at 05:14:49AM -0400, FUJITA Tomonori wrote:
> Well, the reason (nobody has tried) might be that linux/iommu.h
> doesn't look something intended for the generic IOMMU-API.

Oh, and as an additional note, the reason might also be that people were
not aware of its existence :-)

-- 
Joerg Roedel - AMD Operating System Research Center

Advanced Micro Devices GmbH Einsteinring 24 85609 Dornach
General Managers: Alberto Bozzo, Andrew Bowd
Registration: Dornach, Landkr. Muenchen; Registerger. Muenchen, HRB Nr. 43632
