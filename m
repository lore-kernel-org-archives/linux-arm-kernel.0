From: padma.kvr@gmail.com (Padma Venkat)
Date: Tue, 13 Jan 2015 11:40:34 +0530
Subject: [PATCH 2/4] clk: samsung: exynos7: add clocks for SPI block
In-Reply-To: <CAFp+6iHaJ3b9+ERygksNLcyG9PxP2yf-6BTtwFgFgcUOqX+PVg@mail.gmail.com>
References: <1418995427-7712-1-git-send-email-padma.v@samsung.com>
 <1418995427-7712-3-git-send-email-padma.v@samsung.com>
 <CAFp+6iFzawDY1wFA-2AQUHFCk54WsaCJAOkrqvX9t7b-XugY8g@mail.gmail.com>
 <CAFp+6iHaJ3b9+ERygksNLcyG9PxP2yf-6BTtwFgFgcUOqX+PVg@mail.gmail.com>
Message-ID: <CAAgF-BcVRUY-kWRJ0KmpkX6GPsppDBd0O73R_pLdPU=OOen8Kw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ViVek,

On 1/9/15, Vivek Gautam <gautamvivek1987@gmail.com> wrote:
> On Fri, Jan 9, 2015 at 5:18 PM, Vivek Gautam <gautamvivek1987@gmail.com>
> wrote:
>> Hi Padma,
>>
>>
>> On Fri, Dec 19, 2014 at 6:53 PM, Padmavathi Venna <padma.v@samsung.com>
>> wrote:
>>> Add clock support for 5 SPI channels.
>>>
>>> Signed-off-by: Padmavathi Venna <padma.v@samsung.com>
>>> ---

[snip]

>> Same here for SCLK_SPI5, unused in the patch.

ok.

>>
>> [snip]
>>
>> The rest all looks good in this patch. I have also verified from the
>> Exynos7 UM.
>
> missed it earlier. You may also want to add update documentation for
> clock sources
> of peric1 block.

I will add the required source clks.
Thanks for the review.

Padma
>
>
> --
> Best Regards
> Vivek Gautam
> Samsung R&D Institute, Bangalore
> India
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc"
> in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
