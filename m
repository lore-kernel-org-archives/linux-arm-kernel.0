From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 10 Feb 2014 10:43:55 +0000
Subject: [PATCH] arm: add DSB after icache flush in __flush_icache_all()
In-Reply-To: <52F71BAD.80607@gmail.com>
References: <1391592782-18576-1-git-send-email-vkale@apm.com>
 <52F71BAD.80607@gmail.com>
Message-ID: <20140210104355.GE25305@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Feb 09, 2014 at 06:09:49AM +0000, Dirk Behme wrote:
> Am 05.02.2014 10:33, schrieb Vinayak Kale:
> > Add DSB after icache flush to complete the cache maintenance operation.
> >
> > Signed-off-by: Vinayak Kale <vkale@apm.com>
> 
> Should this go to -stable, too?
> 
> I haven't looked into the details, but at least it seems to apply 
> cleanly on a 3.8 kernel.

It should. For the similar arm64 fix I added 'cc: stable' myself (commit
5044bad43ee57).

Thanks.

-- 
Catalin
