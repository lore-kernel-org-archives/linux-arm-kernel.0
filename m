From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Thu, 24 May 2018 08:48:42 +0200
Subject: [rjarzmik:test/daniel 23/34] sound/arm/pxa2xx-ac97.c:27:10: fatal
 error: mach/regs-ac97.h: No such file or directory
In-Reply-To: <831EE4E5E37DCC428EB295A351E662494CB32366@shsmsx102.ccr.corp.intel.com>
 (Philip Li's message of "Thu, 24 May 2018 00:21:39 +0000")
References: <201805231623.n3Qx9qdU%fengguang.wu@intel.com>
 <8545409a-475f-1821-fcef-60b2f85101b6@zonque.org>
 <831EE4E5E37DCC428EB295A351E662494CB31A1D@shsmsx102.ccr.corp.intel.com>
 <87lgcaxxy4.fsf@belgarion.home>
 <831EE4E5E37DCC428EB295A351E662494CB32366@shsmsx102.ccr.corp.intel.com>
Message-ID: <87efi1y2et.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

"Li, Philip" <philip.li@intel.com> writes:

>> Is it possible to exclude a pattern instead ?
>> I mean would it be possible to exclude each branch of the form "test/*" ?
> sure, we will use test/.* to match the branch to exclude.
That's great, thanks a lot.

Cheers.

-- 
Robert
