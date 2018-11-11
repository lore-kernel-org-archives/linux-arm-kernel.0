From: Robert.Richter@cavium.com (Richter, Robert)
Date: Sun, 11 Nov 2018 09:42:31 +0000
Subject: [PATCH 00/10] irqdomain, gic-v3-its: Implement late irq domain
 initialization
In-Reply-To: <e93e7a95-bd12-5695-18da-1ac80b8d595d@huawei.com>
References: <20181107220254.6116-1-rrichter@cavium.com>
 <e93e7a95-bd12-5695-18da-1ac80b8d595d@huawei.com>
Message-ID: <20181111094222.GF4064@rric.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09.11.18 17:19:54, John Garry wrote:
> On 07/11/2018 22:03, Robert Richter wrote:

> >Patches have been tested with Cavium ThunderX and ThunderX2. I have an
> >implementation of CMA ITS table allocation on top of this series
> >available, I will send out patches for this in a couple of days.

> For this follow-on patchset, will it conflict with this:
> https://lkml.org/lkml/2017/6/25/75
> 
> We were planning on reposting with some results.

Both could be implemented, but of course, it changes the same code and
there will be probably conflicts.

-Robert
