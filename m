From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Mon, 24 Jun 2013 19:40:14 +0200
Subject: [PATCH 2/8] at_hdmac: prepare clk before calling enable
In-Reply-To: <20130621024039.GA23141@intel.com>
References: <1371640263-9268-1-git-send-email-b.brezillon@overkiz.com>
 <1371640494-9472-1-git-send-email-b.brezillon@overkiz.com>
 <51C2B2B8.2040104@atmel.com> <20130621024039.GA23141@intel.com>
Message-ID: <51C8847E.5020101@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21/06/2013 04:40, Vinod Koul :
> On Thu, Jun 20, 2013 at 09:43:52AM +0200, Nicolas Ferre wrote:
>> On 19/06/2013 13:14, Boris BREZILLON :
>>> Replace clk_enable/disable with clk_prepare_enable/disable_unprepare to
>>> avoid common clk framework warnings.
>>>
>>> Signed-off-by: Boris BREZILLON <b.brezillon@overkiz.com>
>>
>> Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
>>
>> BTW Vinod, it seems that we have several slave-dma patches pending:
>> do you want me to collect them and send you a pull-request for 3.11?
> I think those are the DT binding one, right? Sorry have been quite busy and
> travelling. I could use the help right now...

Vinod,

I have just sent the pull-request with all patches that you may take for 
3.11 ([GIT PULL] dmaengine: at_hdmac: updates for 3.11). It is a signed 
tag "at91-sdma" on our github space.

I hope that it will be easy for you to take it in your slave-dma git 
tree. If you have any question, please let me know.

Best regards,
-- 
Nicolas Ferre
