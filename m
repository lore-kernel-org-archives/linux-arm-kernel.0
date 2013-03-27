From: jacmet@sunsite.dk (Peter Korsgaard)
Date: Wed, 27 Mar 2013 20:01:20 +0100
Subject: [PATCH 8/9] ARM: OMAP4: PM: Remove L4 wakeup depedency with MPU
 since errata fix exist now
In-Reply-To: <874nfw7kb6.fsf@linaro.org> (Kevin Hilman's message of "Wed, 27
 Mar 2013 11:46:05 -0700")
References: <1361373527-21695-1-git-send-email-santosh.shilimkar@ti.com>
 <1361373527-21695-9-git-send-email-santosh.shilimkar@ti.com>
 <874nfw7kb6.fsf@linaro.org>
Message-ID: <87li98651b.fsf@dell.be.48ers.dk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>>>>> "Kevin" == Kevin Hilman <khilman@linaro.org> writes:

Santosh Shilimkar <santosh.shilimkar@ti.com> writes:

 >> With commit bfd6d021 {ARM: OMAP3+: Implement timer workaround for errata
 >> i103 and i767}, the sync and gptimer synchronization errata got fixed.
 >> 
 >> Hence the l4_wakeup static dependency with MPU can  can be removed

s/can  can/can/

-- 
Bye, Peter Korsgaard
