From: dinguyen@kernel.org (Dinh Nguyen)
Date: Thu, 25 Oct 2018 09:57:16 -0500
Subject: [PATCH] ARM: debug: enable UART1 for socfpga Cyclone5
In-Reply-To: <CAJiuCcfZ7+gaxA5iGhS48eODPsTaZc5-Bd2zXqaAgtNd0fwSKg@mail.gmail.com>
References: <20181009112837.2517-1-peron.clem@gmail.com>
 <e761c76d-a806-402a-b25b-04aee9329dbc@kernel.org>
 <CAJiuCceZr8NsDgBJgA2y61VHdQ3JYQ6_3r4jKooKLbVfRD8eJQ@mail.gmail.com>
 <74512aef-d551-30af-b4cf-25f48047a4ac@kernel.org>
 <20181024065152.yinlj4axprtwdzku@pengutronix.de>
 <CAJiuCcfZ7+gaxA5iGhS48eODPsTaZc5-Bd2zXqaAgtNd0fwSKg@mail.gmail.com>
Message-ID: <2f4d939f-ab25-bab5-8f1c-b919adf4977c@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

On 10/24/2018 09:11 AM, Cl?ment P?ron wrote:
> Hi,
> 
> On Wed, 24 Oct 2018 at 08:51, Uwe Kleine-K?nig
> <u.kleine-koenig@pengutronix.de> wrote:
>>
>> On Tue, Oct 23, 2018 at 03:35:31PM -0500, Dinh Nguyen wrote:
>>>
>>>
>>> On 10/23/2018 09:44 AM, Cl?ment P?ron wrote:
>>>> HI Dinh,
>>>>
>>>> On Tue, 23 Oct 2018 at 16:04, Dinh Nguyen <dinguyen@kernel.org> wrote:
>>>>>
>>>>> Hi Cl?ment,
>>>>>
>>>>> On 10/09/2018 06:28 AM, Cl?ment P?ron wrote:
>>>>>> Cyclone5 and Arria10 doesn't have the same memory map for UART1.
>>>>>>
>>>>>> Split the SOCFPGA_UART1 into 2 options to allow debugging on UART1 for Cylone5.
>>>>>>
>>>>>
>>>>> I'm not sure the need for this patch. Are there any cyclone5 based
>>>>> boards that has UART1 as the debug uart? I see that all of them are
>>>>> using UART0.
>>>>
>>>> There is no upstream device with this UART used. But the board I have
>>>> use it, and there is no limitation to not have it available upstream
>>>> no ?
>>>>
>>>
>>> I see. Then I don't think the patch is applicable because none of the
>>> upstream devices need it. Now, if you were to upstream your board that
>>> uses UART1, then there will be a case for this patch. Do you agree?
> 
> I don't think my board is upstreamable it's not a devkit and not
> really interesting for the community.
> 
> It's really a trivial patch and it will avoid wasting time  to another
> owner of CycloneV board who would like to have debug on UART1
> 

I'll apply this after the merge window.

Thanks,
Dinh
