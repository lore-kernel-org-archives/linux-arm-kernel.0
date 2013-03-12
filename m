From: davem@davemloft.net (David Miller)
Date: Tue, 12 Mar 2013 11:33:28 -0400 (EDT)
Subject: [PATCH] ARM:net: an issue for k which is u32, never < 0
In-Reply-To: <20130311164741.GL4977@n2100.arm.linux.org.uk>
References: <513BECDA.3030803@asianux.com>
 <20130310.171238.330349067962026661.davem@davemloft.net>
 <20130311164741.GL4977@n2100.arm.linux.org.uk>
Message-ID: <20130312.113328.1340895896039295892.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Date: Mon, 11 Mar 2013 16:47:41 +0000

> On Sun, Mar 10, 2013 at 05:12:38PM -0400, David Miller wrote:
>> From: Chen Gang <gang.chen@asianux.com>
>> Date: Sun, 10 Mar 2013 10:15:54 +0800
>> 
>> > 
>> >   k is u32 which never < 0, need type cast, or cause issue.
>> > 
>> > Signed-off-by: Chen Gang <gang.chen@asianux.com>
>> 
>> Who will apply this, ARM folks or me?
> 
> I'm happy if you wish to take the patch:
> 
> Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>

Great, applied, thanks.
