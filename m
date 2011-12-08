From: robherring2@gmail.com (Rob Herring)
Date: Thu, 08 Dec 2011 07:30:11 -0600
Subject: [PATCH v2] irqdomain: protect macro variable in domain iterators
In-Reply-To: <4EE08569.3070009@atmel.com>
References: <1322833997-32083-1-git-send-email-nicolas.ferre@atmel.com>
 <1322832609-24956-1-git-send-email-nicolas.ferre@atmel.com>
 <20111202134458.GD2892@localhost.localdomain> <4EE08569.3070009@atmel.com>
Message-ID: <4EE0BBE3.60508@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/08/2011 03:37 AM, Nicolas Ferre wrote:
> On 12/02/2011 02:44 PM, Dave Martin :
>> On Fri, Dec 02, 2011 at 02:30:09PM +0100, Nicolas Ferre wrote:
>>> Signed-off-by: Nicolas Ferre<nicolas.ferre@atmel.com>
>>
>> Looks OK to me:
>>
>> Acked-by: Dave Martin<dave.martin@linaro.org>
> 
> Rob,
> 
> Do you want a different implementation for this. I think it is the
> simplest way to write this macro...
> 
> If it is ok for you, it will be interesting to include this patch
> quickly so that I will be able to queue my own patches on top of it.
> (Cc: stable can be a good idea also).
> 

Yes, it's fine. The irqdomain patches need to be taken by tglx or acked
by him. I don't think this is needed for stable. The existing users are
fine and new ones aren't going to be added to stable kernels.

Rob
