From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Thu, 01 Mar 2012 15:06:31 +0100
Subject: [GIT PULL] at91: fixes for DMA registration (3.3-rc)
In-Reply-To: <201203011403.11369.arnd@arndb.de>
References: <4F4F49E1.4020902@atmel.com> <201203011149.42948.arnd@arndb.de>
 <4F4F7254.9060306@atmel.com> <201203011403.11369.arnd@arndb.de>
Message-ID: <4F4F8267.5030408@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/01/2012 03:03 PM, Arnd Bergmann :
> On Thursday 01 March 2012, Nicolas Ferre wrote:
>> As discussed on the mailing-list, we experience an out-of-sync situation
>> between the DMA controller driver and the related code in AT91 devices files.
>>
>> Those two patches already queued for 3.4 are correcting the problem that we found on
>> the current 3.3-rc kernels. I have tested that the DMA driver is registering well
>> with those fixes applied.
>>
>> Can you please pull them in a "fixes" branch and send them to Linus before 3.3-final?
> 
> Hi Nicolas,
> 
> I've just sent a pull request for bug fixes yesterday, so I'll wait
> until Linus has pulled that one and probably a few days before I
> send another one.

Sure.

> I have applied it to the fixes branch now but not updated the
> tag that I sent him.

Ok, thanks a lot for your quick help.

Best regards,
-- 
Nicolas Ferre
