From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 20 Jan 2015 12:11:33 +0100
Subject: [PATCHv3 1/2] USB: gadget: atmel_usba_udc: Fixed vbus_prev initial
 state
In-Reply-To: <20150120110240.GA5752@gradator.net>
References: <20150118175621.6b519cdc@bbrezillon>
 <1421601875-9436-1-git-send-email-sylvain.rochet@finsecur.com>
 <1421601875-9436-2-git-send-email-sylvain.rochet@finsecur.com>
 <54BD1028.20303@atmel.com> <20150119185547.GM20386@saruman>
 <20150120110240.GA5752@gradator.net>
Message-ID: <54BE37E5.1050508@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 20/01/2015 12:02, Sylvain Rochet a ?crit :
> Hello,
> 
> On Mon, Jan 19, 2015 at 12:55:47PM -0600, Felipe Balbi wrote:
>> On Mon, Jan 19, 2015 at 03:09:44PM +0100, Nicolas Ferre wrote:
>>> Le 18/01/2015 18:24, Sylvain Rochet a ?crit :
>>>> If vbus gpio is high at init, we should set vbus_prev to true
>>>> accordingly to the current vbus state. Without that, we skip the first
>>>> vbus interrupt because the saved vbus state is not consistent.
>>>>
>>>> Signed-off-by: Sylvain Rochet <sylvain.rochet@finsecur.com>
>>>
>>> Indeed:
>>> Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
>>>
>>> We can also add the following tags:
>>> Fixes: 914a3f3b3754 ("USB: add atmel_usba_udc driver")
>>> Cc: <stable@vger.kernel.org> # 2.6.x-ish
>>
>> Please resend with the proper stable format. Also, this 2.6.x-ish should
>> be 2.6.24+, git describe helps a lot figuring these out.
> 
> Unfortunately I failed to understand what I should do. The "Also" 
> keyword means for me that there are two differents things to fix:
> 
> 1. proper stable format
> 2. 2.6.x-ish ? 2.6.24+
> 
>   2. does not imply fixing 1., isn'it ?

Well, I think it does. My understanding is that fixing '2' is the solution.


> I read SubmittingPatches thoroughly and I can't find a reference to 
> stable format.
> 
> Sylvain

Bye,
-- 
Nicolas Ferre
