From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 4 Sep 2018 14:46:20 +0200
Subject: [PATCH v2 00/15] soc: octeontx2: Add RVU admin function driver
In-Reply-To: <1536062090-30446-1-git-send-email-sunil.kovvuri@gmail.com>
References: <1536062090-30446-1-git-send-email-sunil.kovvuri@gmail.com>
Message-ID: <20180904124620.GC29121@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 04, 2018 at 05:24:35PM +0530, sunil.kovvuri at gmail.com wrote:
> From: Sunil Goutham <sgoutham@marvell.com>
> 
> Resource virtualization unit (RVU) on Marvell's OcteonTX2 SOC supports
> multiple PCIe SRIOV physical functions (PFs) and virtual functions (VFs).
> PF0 is called administrative / admin function (AF) and has privilege access
> to registers to provision different RVU functional blocks to each of
> PF/VF.

Hi Sunil

Please keep netdev in the loop. The people with most experience with
PF/VF tend to hang out there, not arm-soc.

      Andrew
