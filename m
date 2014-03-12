From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 12 Mar 2014 17:28:28 +0100
Subject: [PATCH RESEND] usb: at91-udc: fix irq and iomem resource retrieval
In-Reply-To: <20140312153140.GA8141@kroah.com>
References: <1390488102-8548-1-git-send-email-jjhiblot@traphandler.com>
 <1392210209-22142-1-git-send-email-nicolas.ferre@atmel.com>
 <532075EC.7060809@atmel.com> <20140312153140.GA8141@kroah.com>
Message-ID: <53208B2C.6020208@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/03/2014 16:31, Greg Kroah-Hartman :
> On Wed, Mar 12, 2014 at 03:57:48PM +0100, Nicolas Ferre wrote:
>> On 12/02/2014 14:03, Nicolas Ferre :
>>> From: Jean-Jacques Hiblot <jjhiblot@traphandler.com>
>>>
>>> When using dt resources retrieval (interrupts and reg properties) there is
>>> no predefined order for these resources in the platform dev resource
>>> table. Also don't expect the number of resource to be always 2.
>>>
>>> Signed-off-by: Jean-Jacques Hiblot <jjhiblot@traphandler.com>
>>> Acked-by: Boris BREZILLON <b.brezillon@overkiz.com>
>>> Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
>>> Cc: stable <stable@vger.kernel.org> # 3.4
>>
>> Gentle ping, after having resent the patch itself.
> 
> It helps if you send it to the correct maintainer, remember,
> scripts/get_maintainer.pl is your friend...

Indeed. I add Felipe to my next attempt: sorry for the (repeated) noise.

Bye,
-- 
Nicolas Ferre
