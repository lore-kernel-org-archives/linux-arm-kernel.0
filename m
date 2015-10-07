From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Wed, 7 Oct 2015 22:57:01 +0530
Subject: [PATCH] PM / OPP: fix debugfs files for 64-bit
In-Reply-To: <20151007171949.GB9702@kroah.com>
References: <5706174.BUsqiXljxZ@wuerfel> <20151007105911.GC9892@linux>
 <20151007110302.GD9892@linux> <20151007110755.GA6601@kroah.com>
 <20151007112149.GB22530@linux> <20151007125735.GA8170@kroah.com>
 <20151007130324.GA4557@linux> <20151007171949.GB9702@kroah.com>
Message-ID: <20151007172701.GF4557@linux>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07-10-15, 18:19, Greg Kroah-Hartman wrote:
> Ok, then stop exporting it in debugfs and everyone will be happy :)

Hehe, not really. See I am not happy :(

So, what do you suggest? Should we create debugfs_create_ulong()? And
how to implement that? With existing u32/u64 APIs or from scratch?

-- 
viresh
