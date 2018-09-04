From: sunil.kovvuri@gmail.com (Sunil Kovvuri)
Date: Tue, 4 Sep 2018 21:44:24 +0530
Subject: [PATCH v2 00/15] soc: octeontx2: Add RVU admin function driver
In-Reply-To: <20180904124620.GC29121@lunn.ch>
References: <1536062090-30446-1-git-send-email-sunil.kovvuri@gmail.com>
 <20180904124620.GC29121@lunn.ch>
Message-ID: <CA+sq2CfF2L5yyrXOhdv5omhrHcjP+tJBcBMFVyQJQ0EmCbftdQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 4, 2018 at 6:16 PM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Tue, Sep 04, 2018 at 05:24:35PM +0530, sunil.kovvuri at gmail.com wrote:
> > From: Sunil Goutham <sgoutham@marvell.com>
> >
> > Resource virtualization unit (RVU) on Marvell's OcteonTX2 SOC supports
> > multiple PCIe SRIOV physical functions (PFs) and virtual functions (VFs).
> > PF0 is called administrative / admin function (AF) and has privilege access
> > to registers to provision different RVU functional blocks to each of
> > PF/VF.
>
> Hi Sunil
>
> Please keep netdev in the loop. The people with most experience with
> PF/VF tend to hang out there, not arm-soc.
>
>       Andrew

Sure, will submit again with netdev in loop.

Sunil.
