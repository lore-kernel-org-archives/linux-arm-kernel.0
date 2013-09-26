From: cjb@laptop.org (Chris Ball)
Date: Wed, 25 Sep 2013 21:46:53 -0400
Subject: [PATCH] mmc: atmel-mci: abort transfer on timeout error
In-Reply-To: <522ED03F.5070404@atmel.com> (Nicolas Ferre's message of "Tue, 10
 Sep 2013 09:54:39 +0200")
References: <1378740596-25026-1-git-send-email-ludovic.desroches@atmel.com>
 <522ED03F.5070404@atmel.com>
Message-ID: <87a9j04anm.fsf@octavius.laptop.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Sep 10 2013, Nicolas Ferre wrote:
> On 09/09/2013 17:29, ludovic.desroches at atmel.com :
>> From: Ludovic Desroches <ludovic.desroches@atmel.com>
>>
>> When a software timeout occurs, the transfer is not stopped. In DMA case, it
>> causes DMA channel to be stuck because the transfer is still active causing
>> following transfers to be queued but not computed.
>>
>> Cc: <stable@vger.kernel.org> #3.9+
>> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
>> Reported-by: Alexander Morozov <etesial@gmail.com>
>
> Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

Thanks, pushed to mmc-next for 3.12.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
