From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 18 Jun 2013 10:05:30 +0200
Subject: [GIT PULL] at91: Device Tree update for 3.11 #2
In-Reply-To: <CAOesGMjHTSB3y3+TxLqM=s06jg8Qx8XnEeW9c2dDcWnneZPVXA@mail.gmail.com>
References: <1370279139-7181-1-git-send-email-nicolas.ferre@atmel.com>
 <1371250067-19317-1-git-send-email-nicolas.ferre@atmel.com>
 <20130615015224.GA25585@quad.lixom.net>
 <EABCC4A72A203F4BA2E04297CF0282C427D1E112@hnombx01.corp.atmel.com>
 <CAOesGMjHTSB3y3+TxLqM=s06jg8Qx8XnEeW9c2dDcWnneZPVXA@mail.gmail.com>
Message-ID: <51C014CA.7040700@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17/06/2013 18:56, Olof Johansson :
> On Mon, Jun 17, 2013 at 1:34 AM, Ferre, Nicolas <Nicolas.FERRE@atmel.com> wrote:
>>
>>> On Sat, Jun 15, 2013 at 12:47:47AM +0200, Nicolas Ferre wrote:
>>>> Arnd, Olof,
>>>>
>>>> Additional pull-request for AT91 DT patches.
>>>> It contains the remaining part of the USB gadget pull-request that I sent you
>>>> last week. After having split it, here is the DT part.
>>>> It also contains the update of DMA bindings: it is the AT91 part the should go
>>>> through arm-soc. I have included the patch (ARM: at91: dt: add header to define
>>>> at_hdmac configuration) so that we avoid build errors whichever git tree
>>>> (slave-dma or arm-soc) is merged first.
>>>> A SPI DT patch for at91sam9x5 is also added.
>>>>
>>>> Thanks, best regards,
>>>>
>>>> The following changes since commit 028633c238f91dc113520a7ad25d37b2ba9068af:
>>>>
>>>>    ARM: at91/dt: add pinctrl definition for at91 tc blocks (2013-05-31 22:40:37 +0200)
>>>>
>>>> are available in the git repository at:
>>>>
>>>>    git://github.com/at91linux/linux-at91.git tags/at91-dt
>>>
>>> Pulled, thanks.
>>
>> Hi,
>>
>> I do not see it appearing in arm-soc/at91/dt branch even though is it present in arm-soc/for-next: is it normal?
>
> I had missed to push that (and the driver branch) up. They are there
> now, as at91/dt2 and at91/drivers. Fixed the bad branch name in
> arm-soc-for-next-contents.txt as well.

Nice, thanks.

Bye,
-- 
Nicolas Ferre
