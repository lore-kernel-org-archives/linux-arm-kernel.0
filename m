From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sat, 16 Apr 2016 10:09:19 +0200
Subject: [PATCH] dmaengine: pxa: handle bus errors
In-Reply-To: <20160416051834.GY2274@localhost> (Vinod Koul's message of "Sat,
 16 Apr 2016 10:48:34 +0530")
References: <1459200744-13245-1-git-send-email-robert.jarzmik@free.fr>
 <20160413135324.GQ2274@localhost> <87k2k0t5gh.fsf@belgarion.home>
 <20160416051834.GY2274@localhost>
Message-ID: <87d1pqt1ow.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Vinod Koul <vinod.koul@intel.com> writes:

> On Thu, Apr 14, 2016 at 08:23:26PM +0200, Robert Jarzmik wrote:
>> Vinod Koul <vinod.koul@intel.com> writes:
>> 
>> > So what exactly are you trying to fix/achive here?
>> Euh you mean the first chapter about the "endless spin" is not clear ?
>> This is what I'm trying to fix, the unstoppable endless relauch of a descriptor
>> doomed to make the same bus error over and over again.
>
> Okay so IIUC the patch here essential stops all transfers and abort the
> channel, right?
That's exactly it, yes, abort the channel, stop all the transfers.

Cheers.

-- 
Robert
