From: olof@lixom.net (Olof Johansson)
Date: Fri, 8 Nov 2013 11:19:09 -0800
Subject: [PATCH v3 7/9] ARM: add Armada 1500 and Sony NSZ-GS7 device tree
 files
In-Reply-To: <527D38AF.4010601@gmail.com>
References: <1381235073-17134-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1383661723-17956-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1383661723-17956-8-git-send-email-sebastian.hesselbarth@gmail.com>
 <0AF697FD-60AA-4B8B-A35F-3DF2FFBCF7AF@codeaurora.org>
 <20131108165721.GA10335@titan.lakedaemon.net>
 <8DC09031-553C-4FD5-8F05-F93D6FE40F3A@codeaurora.org>
 <20131108182415.GG10335@titan.lakedaemon.net>
 <CAOesGMhfr3CNxKNRJa+eJepr2Fc-jx4rTQ7cPerTkQM-CyzuCg@mail.gmail.com>
 <527D38AF.4010601@gmail.com>
Message-ID: <CAOesGMh4RPs3YTWdg=kNwD4-u3xKT6Zsw9dqN4doHLse48P2Sw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 8, 2013 at 11:17 AM, Sebastian Hesselbarth
<sebastian.hesselbarth@gmail.com> wrote:
> On 11/08/2013 08:14 PM, Olof Johansson wrote:
>>
>> On Fri, Nov 8, 2013 at 10:24 AM, Jason Cooper <jason@lakedaemon.net>
>> wrote:
>>>
>>> On Fri, Nov 08, 2013 at 12:06:26PM -0600, Kumar Gala wrote:
>>>>
>>>> On Nov 8, 2013, at 10:57 AM, Jason Cooper wrote:
>>>>>
>>>>> On Fri, Nov 08, 2013 at 10:13:19AM -0600, Kumar Gala wrote:
>>>>>>
>>>>>> On Nov 5, 2013, at 8:28 AM, Sebastian Hesselbarth wrote:
>>>>>
>>>>> ...
>>>>>>>
>>>>>>> .../devicetree/bindings/arm/marvell,berlin.txt     |   24 +++
>>>>>>> arch/arm/boot/dts/Makefile                         |    2 +
>>>>>>> arch/arm/boot/dts/berlin2-sony-nsz-gs7.dts         |   29 +++
>>>>>>> arch/arm/boot/dts/berlin2.dtsi                     |  227
>>>>>>> ++++++++++++++++++++
>>>>>>> 4 files changed, 282 insertions(+)
>>>>>>> create mode 100644
>>>>>>> Documentation/devicetree/bindings/arm/marvell,berlin.txt
>>>>>>> create mode 100644 arch/arm/boot/dts/berlin2-sony-nsz-gs7.dts
>>>>>>> create mode 100644 arch/arm/boot/dts/berlin2.dtsi
>>>>>>
>>>>>>
>>>>>> Haven't we been trying to go away from non-prefixed dts/dtsi?
>>>>>
>>>>>
>>>>> hmmm, this is the first I've heard of that.  Although, your proposal
>>>>> (in another thread) makes more sense now.  :)
>>>>>
>>>>>> So should these be something like marvell-berlin2-...
>>>>>
>>>>>
>>>>> I don't recall this being brought up at the summit, nor in Grant's
>>>>> report.  I do need to give it a more careful read this weekend, though.
>>>>> Perhaps I missed something.
>>>>
>>>>
>>>> This was based on review comments Olof gave when we pushed some .dts
>>>> files for MSM/APQ Qualcomm Technologies soc/boards.
>>>
>>>
>>> As Andrew Lunn mentioned to me earlier, we should consider the fact that
>>> the dts file names are being used by Debian's flash-kernel.  Oh no!
>>> Another ABI! ;-)
>>
>>
>> Yes, the names are mostly stable. ST-Ericsson renamed their dts files
>> and it caused some pain, some build environments have them hardcoded,
>> etc.
>
>
> Ok, I was just going to ask, if we should stich some rename-patches for
> mvebu SoCs.. but the above answers that.

For those that you think are in limited use, please do (the whole
stable ABI argument about no users means no breakage), but for others
we might have to be more careful.

It's really more about the name of the generated dtb than the dts
though, but still.


-Olof
