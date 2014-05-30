From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 30 May 2014 01:13:54 +0100
Subject: [PATCH v3] ARM: mm: support big-endian page tables
In-Reply-To: <20140529075837.GA29812@arm.com>
References: <534F9F79.9050503@huawei.com>
 <87ob00wau2.fsf@approximate.cambridge.arm.com>
 <20140423132033.GE5649@arm.com> <53587C48.8080103@huawei.com>
 <5386A799.7040403@huawei.com> <20140529075837.GA29812@arm.com>
Message-ID: <20140530001354.GN3693@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 29, 2014 at 08:58:38AM +0100, Will Deacon wrote:
> On Thu, May 29, 2014 at 04:20:57AM +0100, Jianguo Wu wrote:
> > Hi Russell,
> > Could you please merge this to mainline? Thanks!
> 
> Give him a chance, it's not the merge window yet ;) I can see it queued in
> his for-next branch.

It's not like it's something that has ever worked in the past - so
it's really a new feature rather than a bug fix, even through we've
been growing BE support in other areas.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
