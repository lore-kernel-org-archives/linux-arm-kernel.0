From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Sun, 22 Sep 2013 14:12:32 +0200
Subject: [PATCH 04/26] clk: prima2: declare OF clock provider
In-Reply-To: <523ABA7A.50305@gmail.com>
References: <1379526839-14798-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1379526839-14798-5-git-send-email-sebastian.hesselbarth@gmail.com>
 <CAGsJ_4xC_g1C-pGQGrcLOBhKLSMG3D8369DRPoFgNZhKqs-aTQ@mail.gmail.com>
 <523ABA7A.50305@gmail.com>
Message-ID: <523EDEB0.1060601@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/19/2013 10:48 AM, Sebastian Hesselbarth wrote:
> On 09/19/13 10:45, Barry Song wrote:
>>> @@ -1124,3 +1106,4 @@ void __init sirfsoc_of_clk_init(void)
>>>
>>>          of_clk_add_provider(np, of_clk_src_onecell_get, &clk_data);
>>>   }
>>> +CLK_OF_DECLARE(sirfsoc_clk, "sirf,prima2-clkc", sirfsoc_clk_init);
>>
>> hi Sebastian,
>> what if the driver is compatible with multiple clk controllers and we
>> want to add another compatible string here except "sirf,prima2-clkc"?
>>
>> -barry
>>
>
> Just add
> CLK_OF_DECLARE(other_fancy_clk, "sirf,different-compatible",
> sirfsoc_clk_init);

Barry, BTW, do I get your Acked-By for this and the corresponding
removal patch?

Sebastian
