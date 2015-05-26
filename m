From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 26 May 2015 11:57:58 +0100
Subject: [BUG] Read-Only THP causes stalls (commit 10359213d)
In-Reply-To: <20150526080848.GA27075@cbox>
References: <20150524193404.GD16910@cbox> <20150525141525.GB26958@redhat.com>
 <20150526080848.GA27075@cbox>
Message-ID: <556451B6.6080303@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26/05/15 09:08, Christoffer Dall wrote:

[...]

>> Then push the system into swap with some memhog -r1000 xG.
> 
> what is memhog?  I couldn't find the utility in Google...

This looks to be part of the numactl suite, though Debian doesn't seem
to include it in its numactl package...

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
