From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 15 Mar 2012 14:31:35 +0000
Subject: [PATCH v4 09/15] ARM: ux500: convert to twd_local_timer_register()
 interface
In-Reply-To: <4F61D6CA.8060002@arm.com>
References: <1327061042-14857-1-git-send-email-marc.zyngier@arm.com>
 <1327061042-14857-10-git-send-email-marc.zyngier@arm.com>
 <CANmRt2gjhg-nznAOxQHA1g7EX+F4uEjp1nW5iT3Rtw4s8y5uGg@mail.gmail.com>
 <4F60D7DD.50705@linaro.org> <4F61D6CA.8060002@arm.com>
Message-ID: <4F61FD47.4030603@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15/03/12 11:47, Marc Zyngier wrote:
> On 14/03/12 17:39, Lee Jones wrote:
> 
>> NAK: Won't build. :(
> 
> Thanks for noticing this.
> 
> I've just pushed a fix to local_timers-for-arm-soc, and the patch should
> be on the ML shortly.

I have tested it. Works okay.

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
M: +44 77 88 633 515
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
