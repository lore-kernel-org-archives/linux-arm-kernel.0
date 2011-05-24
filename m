From: bill_carson@126.com (bill)
Date: Tue, 24 May 2011 15:15:35 +0800 (CST)
Subject: Query about ARM cache model
Message-ID: <6bad69aa.1871b.13020dbd501.Coremail.bill_carson@126.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Russel:)

May I ask one question about ARM cache model? 
I have tried to understand it, but merely get part of it.

Why use _CACHE and MULTI_CACHE to switch cache operations between cache-xxx.S and proc-xxx.S ?
Take CPU_ARM920T for example,MULTI_CACHE is defined in cachflush.h, 
so what's cache operations in cache-v4wt.S for ?



Thanks for your time.

bill









        
