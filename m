From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 15 Mar 2012 11:47:22 +0000
Subject: [PATCH v4 09/15] ARM: ux500: convert to twd_local_timer_register()
 interface
In-Reply-To: <4F60D7DD.50705@linaro.org>
References: <1327061042-14857-1-git-send-email-marc.zyngier@arm.com>
 <1327061042-14857-10-git-send-email-marc.zyngier@arm.com>
 <CANmRt2gjhg-nznAOxQHA1g7EX+F4uEjp1nW5iT3Rtw4s8y5uGg@mail.gmail.com>
 <4F60D7DD.50705@linaro.org>
Message-ID: <4F61D6CA.8060002@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14/03/12 17:39, Lee Jones wrote:

> NAK: Won't build. :(

Thanks for noticing this.

I've just pushed a fix to local_timers-for-arm-soc, and the patch should
be on the ML shortly.

	M.
-- 
Jazz is not dead. It just smells funny...
