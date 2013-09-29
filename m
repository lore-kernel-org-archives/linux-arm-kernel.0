From: 21cnbao@gmail.com (Barry Song)
Date: Sun, 29 Sep 2013 12:49:20 +0800
Subject: [PATCH 04/26] clk: prima2: declare OF clock provider
In-Reply-To: <5245CCBF.3070206@gmail.com>
References: <1379526839-14798-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1379526839-14798-5-git-send-email-sebastian.hesselbarth@gmail.com>
 <CAGsJ_4xC_g1C-pGQGrcLOBhKLSMG3D8369DRPoFgNZhKqs-aTQ@mail.gmail.com>
 <523ABA7A.50305@gmail.com> <523EDEB0.1060601@gmail.com>
 <CAGsJ_4yPcM4YM_i-JMCoDeRb5zKWJyNEt+jnMJ6LqoF5gC3KhA@mail.gmail.com>
 <5245CCBF.3070206@gmail.com>
Message-ID: <CAGsJ_4w73Kh-vie97JC21=4dnbNGaOm-q+yJAn_pT73Kv8nXUQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2013/9/28 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>:
> On 09/22/2013 12:37 PM, Barry Song wrote:
>>
>> 2013/9/22 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>:
>>>
>>> On 09/19/2013 10:48 AM, Sebastian Hesselbarth wrote:
>>>>
>>>>
>>>> On 09/19/13 10:45, Barry Song wrote:
>>>>>>
>>>>>>
>>>>>> @@ -1124,3 +1106,4 @@ void __init sirfsoc_of_clk_init(void)
>>>>>>
>>>>>>           of_clk_add_provider(np, of_clk_src_onecell_get, &clk_data);
>>>>>>    }
>>>>>> +CLK_OF_DECLARE(sirfsoc_clk, "sirf,prima2-clkc", sirfsoc_clk_init);
>>>>>
>>>>>
>>>>>
>>>>> hi Sebastian,
>>>>> what if the driver is compatible with multiple clk controllers and we
>>>>> want to add another compatible string here except "sirf,prima2-clkc"?
>>>>>
>>>>> -barry
>>>>>
>>>>
>>>> Just add
>>>> CLK_OF_DECLARE(other_fancy_clk, "sirf,different-compatible",
>>>> sirfsoc_clk_init);
>>>
>>>
>>>
>>> Barry, BTW, do I get your Acked-By for this and the corresponding
>>> removal patch?
>>
>>
>> Sebastian, would you wait for a while as i need to merge them and make a
>> test.
>
>
> Sure, take your time.
> I now have almost all Acked-by's for the other patches, would be
> great if you find some time to test this on prima2 anytime soon.

Acked-by: Barry Song <Baohua.Song@csr.com>

i have another clock
patchset:http://permalink.gmane.org/gmane.linux.ports.arm.kernel/268241

i will rebase mine against your this one.

>
> Sebastian

-barry
