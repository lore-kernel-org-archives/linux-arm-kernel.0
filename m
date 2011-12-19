From: m-karicheri2@ti.com (Karicheri, Muralidharan)
Date: Mon, 19 Dec 2011 17:21:58 +0000
Subject: Status of the following patch (clocksource sched_clock) ?
Message-ID: <3E54258959B69E4282D79E01AB1F32B7249324@DFLE34.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I am running into a clocksource wrap around issue due to which sched_clock() returned value is wrapped around at clocksource timeout rate. I see this issue is addressed in 
http://www.spinics.net/lists/arm-kernel/msg122716.html

Could someone tell me what is the status of this patch? I want to try it on my target platform which is a davinci variant. 

Murali Karicheri
Software Design Engineer
email: m-karicheri2 at ti.com
