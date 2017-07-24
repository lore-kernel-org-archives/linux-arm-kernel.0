From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Mon, 24 Jul 2017 23:22:41 +0530
Subject: [PATCH 1/8] mailbox: introduce ARM SMC based mailbox
In-Reply-To: <0aaba7fb-2183-2d4d-ba04-64b30cd0ae10@arm.com>
References: <20170630095608.24943-1-andre.przywara@arm.com>
 <20170630095608.24943-2-andre.przywara@arm.com>
 <CABb+yY18Aye3wr2A9-+jemqc=VSRyUA+xzKGo9s0G4KCt1ovyA@mail.gmail.com>
 <22d23c1d-ea8d-9829-4624-6305cd83ad4a@arm.com>
 <CABb+yY2hjfXdiCSZXd5TJf8=janwjWEo2oSqrxdoWc=1oUtteQ@mail.gmail.com>
 <0aaba7fb-2183-2d4d-ba04-64b30cd0ae10@arm.com>
Message-ID: <CABb+yY0LYagAOet-KgP+PB__t26LdCSCnxtH6h_X+T37sq_5Wg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 24, 2017 at 11:08 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:
> On 24/07/17 18:20, Jassi Brar wrote:

>>
>>> I see that the SCPI firmware driver (as the user of the mailbox API) is
>>> expecting the return value from a0 as returned above, translating the
>>> firmware error codes into Linux' ones.
>>>
>> I am afraid, SCPI driver is not the golden example for client drivers
>> to follow. It is supposed to work only with MHU, and then, it is
>> likely to break if some other protocol is running parallel to it.
>>
>
> Not sure why do you say it works only with ARM MHU ? AmLogic uses it
> with their mailbox driver. However they followed an interim version of
> the SCPI spec which is termed "legacy" in the driver.
>
Screw coding... Just tell me what stuff do you smoke? Must be really good!
