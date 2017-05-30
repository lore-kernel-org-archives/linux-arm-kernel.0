From: illusionist.neo@gmail.com (Shubham Bansal)
Date: Wed, 31 May 2017 00:20:01 +0530
Subject: [PATCH v2] arm: eBPF JIT compiler
In-Reply-To: <CAHgaXd+HyzFLcQ8Lwam0N2TOVz_=JpQ+m2Myhs_+gZjdsHUdVg@mail.gmail.com>
References: <1495754003-21099-1-git-send-email-illusionist.neo@gmail.com>
 <20170525232317.GA30485@lunn.ch>
 <CAHgaXdKSqX1L7LX3OAoA=v=Cne9Un-+dxPZ2bLMBOCOJ+ADRHQ@mail.gmail.com>
 <CAHgaXdKNOSQiLyo2r7ANW97t+Dqx+wFOc8wZ_t1MZocER1MUuw@mail.gmail.com>
 <CAHgaXd+HyzFLcQ8Lwam0N2TOVz_=JpQ+m2Myhs_+gZjdsHUdVg@mail.gmail.com>
Message-ID: <CAHgaXdJ+++AKL7YbtZcOunnLpTG3R6Om-H3gxxvhb4_y-HRHFA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

I tried everything I could to run a ARMv6 machine in last 4 days but I
am not able to. If nobody is willing to test the code no there
machine, may be we should not merge the code.
I have been more than happy to assist anyone who want to test it but
it looks like other people don't need it. I guess, it was a wasted
effort.

I don't have anything more to offer in regarding to this patch.
Thank you.

Best,
Shubham Bansal


On Fri, May 26, 2017 at 10:27 PM, Shubham Bansal
<illusionist.neo@gmail.com> wrote:
> Hi Andrew,
>
> Did you get the time to test the code with CONFIG_FRAME_POINTER? It
> would be great if you could check if it works on ARMv5 so that Russell
> can look at the patch.
>
> Thanks.
> Best,
> Shubham Bansal
>
>
> On Fri, May 26, 2017 at 5:06 AM, Shubham Bansal
> <illusionist.neo@gmail.com> wrote:
>> Just to add. It a very very small part which deal with
>> CONFIG_FRAME_POINTER just one move instruction.
>> Best,
>> Shubham Bansal
>>
>>
>> On Fri, May 26, 2017 at 5:04 AM, Shubham Bansal
>> <illusionist.neo@gmail.com> wrote:
>>> Hi Andrew,
>>>
>>> Oh. I didn't knew. Can you test it now and confirm it? I think it will
>>> work and wouldn't take much of the time.
>>>
>>> Please.
>>> Best,
>>> Shubham Bansal
>>>
>>>
>>> On Fri, May 26, 2017 at 4:53 AM, Andrew Lunn <andrew@lunn.ch> wrote:
>>>>> Tested on ARMv7 with QEMU by me (Shubham Bansal).
>>>>> Tested on ARMv5 by Andrew Lunn (andrew at lunn.ch).
>>>>> Expected to work on ARMv6 as well, as its a part ARMv7 and part ARMv5.
>>>>> Although, a proper testing is not done for ARMv6.
>>>>>
>>>>> Both of these testing are done with and without CONFIG_FRAME_POINTER
>>>>> separately for LITTLE ENDIAN machine.
>>>>
>>>> Nope. I only tested it in the default configuration of mvebu_v5_defconfig.
>>>> Please change the 'Both' to 'Some'.
>>>>
>>>>       Andrew
