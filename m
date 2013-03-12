From: gang.chen@asianux.com (Chen Gang)
Date: Tue, 12 Mar 2013 08:01:07 +0800
Subject: [PATCH] ARM:net: an issue for k which is u32, never < 0
In-Reply-To: <20130311164741.GL4977@n2100.arm.linux.org.uk>
References: <513BECDA.3030803@asianux.com>
 <20130310.171238.330349067962026661.davem@davemloft.net>
 <20130311164741.GL4977@n2100.arm.linux.org.uk>
Message-ID: <513E7043.4090304@asianux.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2013?03?12? 00:47, Russell King - ARM Linux ??:
> On Sun, Mar 10, 2013 at 05:12:38PM -0400, David Miller wrote:
>> > From: Chen Gang <gang.chen@asianux.com>
>> > Date: Sun, 10 Mar 2013 10:15:54 +0800
>> > 
>>> > > 
>>> > >   k is u32 which never < 0, need type cast, or cause issue.
>>> > > 
>>> > > Signed-off-by: Chen Gang <gang.chen@asianux.com>
>> > 
>> > Who will apply this, ARM folks or me?
> I'm happy if you wish to take the patch:
> 
> Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>
> 
> Thanks.
> 
> 

  thank you very much.

  :-)

-- 
Chen Gang

Asianux Corporation
