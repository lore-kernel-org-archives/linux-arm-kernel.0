From: will.deacon@arm.com (Will Deacon)
Date: Wed, 3 Sep 2014 10:03:01 +0100
Subject: [PATCH] ARM: drop ISAR0 workaround for B15
In-Reply-To: <20140902234924.GZ18411@ld-irv-0074>
References: <1407797053-12544-1-git-send-email-gregory.0xf0@gmail.com>
 <20140813194047.GA18411@ld-irv-0074>
 <20140902234924.GZ18411@ld-irv-0074>
Message-ID: <20140903090301.GA32378@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 03, 2014 at 12:49:24AM +0100, Brian Norris wrote:
> Ping.
> 
> Is this worthy of 3.17-rc? Or should it just be queued for 3.18, as it's
> only removing redundant info?

Since it's not actually fixing anything, I don't think it qualifies as a
fix. You can still put it into rmk's patch system though, as I don't see
this conflicting with anything in the pipeline.

Will
