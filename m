From: computersforpeace@gmail.com (Brian Norris)
Date: Thu, 7 Jan 2016 10:27:09 -0800
Subject: [PATCH v4 55/58] mtd: nand: add helpers to access ->priv
In-Reply-To: <20160107182140.02111dc1@bbrezillon>
References: <1449734442-18672-1-git-send-email-boris.brezillon@free-electrons.com>
 <1449734442-18672-56-git-send-email-boris.brezillon@free-electrons.com>
 <20151218221758.GQ10460@google.com>
 <20151219040124.7ffe4274@bbrezillon>
 <20160106231323.GM109450@google.com>
 <20160107155237.7271aa7e@bbrezillon>
 <20160107171700.GE109450@google.com>
 <20160107182140.02111dc1@bbrezillon>
Message-ID: <20160107182709.GA79906@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

(Re-constructing CC list)

On Thu, Jan 07, 2016 at 06:21:40PM +0100, Boris Brezillon wrote:
> On Thu, 7 Jan 2016 09:17:00 -0800
> Brian Norris <computersforpeace@gmail.com> wrote:
> > So are these last few patches still applicable as-is, or should I await
> > a new submission?
> 
> It still applies correctly (I rebased it on l2-mtd/master).
> You may want to adapt the jz4780 driver to make use of these helpers.

OK. Fixed some small conflicts and pushed patches 55-58 to l2-mtd.git.
Thanks!

Brian
