From: jamie@jamieiles.com (Jamie Iles)
Date: Tue, 30 Nov 2010 10:08:02 +0000
Subject: ARM perf events spin locks
Message-ID: <20101130100802.GB4398@pulham.picochip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

I think we should convert the spinlocks in the ARM perf events code to raw 
spinlocks for realtime. Should we wait for your split set to get merged first 
before doing this?

Jamie
