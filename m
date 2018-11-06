From: keith.busch@intel.com (Keith Busch)
Date: Tue, 6 Nov 2018 10:26:08 -0700
Subject: [PATCH 00/12] error handling and pciehp maintenance
In-Reply-To: <20181106172100.GA22063@e107981-ln.cambridge.arm.com>
References: <20180918235848.26694-1-keith.busch@intel.com>
 <20181004214015.GK120535@bhelgaas-glaptop.roam.corp.google.com>
 <20181004221137.GB21834@localhost.localdomain>
 <20181005173145.GL120535@bhelgaas-glaptop.roam.corp.google.com>
 <20181008161847.GA30971@localhost.localdomain>
 <20181106163400.GA21193@e107981-ln.cambridge.arm.com>
 <20181106164751.GA6217@localhost.localdomain>
 <20181106172100.GA22063@e107981-ln.cambridge.arm.com>
Message-ID: <20181106172608.GB6217@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 06, 2018 at 05:21:00PM +0000, Lorenzo Pieralisi wrote:
> If you have a simple reproducer for the bugs I am happy to help you test
> it (I can also apply arm64 DYNAMIC_FTRACE_WITH_REGS patches and test that
> new code path if that's the final direction we are taking).

The easiest way to reproduce is load the aer_inject module, inject an
error into a bridge, then remove the bridge and rescan.
