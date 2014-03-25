From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Tue, 25 Mar 2014 15:12:40 -0600
Subject: Intel I350 mini-PCIe card (igb) on Mirabox (mvebu / Armada 370)
In-Reply-To: <20140325213638.5aba54b6@skate>
References: <CAAfodu1eC6=mKwfowW6bmTtf_DcOL_oNQg77kSz+ykfHkMTN-w@mail.gmail.com>
 <20140325202249.GA10378@obsidianresearch.com>
 <20140325213638.5aba54b6@skate>
Message-ID: <20140325211240.GB14718@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 25, 2014 at 09:36:38PM +0100, Thomas Petazzoni wrote:

> We have recently identified a weird thing on Armada 38x, maybe previous
> revisions are affected as well. We haven't fully understood the problem
> yet, but the following patch allows PCIe devices to be detected in all
> situations on Armada 38x. It seems like setting the local device number
> requires "some time" to be taken into account.

What was the value of mvebu_pcie_link_up around this point?

PHY training would be the most likely time sensitive thing to muck up
discovery..

Jason
