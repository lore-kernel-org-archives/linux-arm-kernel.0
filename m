From: gang.chen@asianux.com (Chen Gang)
Date: Mon, 11 Mar 2013 12:53:00 +0800
Subject: [PATCH] ARM:net: an issue for k which is u32, never < 0
In-Reply-To: <20130310.171238.330349067962026661.davem@davemloft.net>
References: <513BECDA.3030803@asianux.com>
 <20130310.171238.330349067962026661.davem@davemloft.net>
Message-ID: <513D632C.7030709@asianux.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2013?03?11? 05:12, David Miller ??:
> From: Chen Gang <gang.chen@asianux.com>
> Date: Sun, 10 Mar 2013 10:15:54 +0800
> 
>> > 
>> >   k is u32 which never < 0, need type cast, or cause issue.
>> > 
>> > Signed-off-by: Chen Gang <gang.chen@asianux.com>
> Who will apply this, ARM folks or me?
> 
> 

  sorry I don't know, either. I get the mail addresses by
./scripts/get_maintainers.pl. it includes you.

  if no others reply within a week, I hope you can help to check and
apply it.

  thanks.

-- 
Chen Gang

Asianux Corporation
