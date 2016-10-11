From: patrice.chotard@st.com (Patrice Chotard)
Date: Tue, 11 Oct 2016 09:05:05 +0200
Subject: [PATCH 15/19] reset: sti: Remove STiH415/6 reset support
In-Reply-To: <1474963347.2494.8.camel@pengutronix.de>
References: <1473859677-9231-1-git-send-email-peter.griffin@linaro.org>
 <1473859677-9231-16-git-send-email-peter.griffin@linaro.org>
 <1474963347.2494.8.camel@pengutronix.de>
Message-ID: <b9a50ba1-9932-0d71-6b61-efccee587d74@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Philipp

On 09/27/2016 10:02 AM, Philipp Zabel wrote:
> Hi Peter,
> 
> Am Mittwoch, den 14.09.2016, 14:27 +0100 schrieb Peter Griffin:
>> Support for STiH415/6 SoCs is being removed from the
>> kernel because the platforms are obsolete. This patch removes
>> the reset drivers for these SoC's.
>>
>> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
>> Cc: <p.zabel@pengutronix.de>
>> ---

[...]

>> -	.driver = {
>> -		.name = "reset-stih416",
>> -		.of_match_table = stih416_reset_match,
>> -	},
>> -};
>> -
>> -static int __init stih416_reset_init(void)
>> -{
>> -	return platform_driver_register(&stih416_reset_driver);
>> -}
>> -arch_initcall(stih416_reset_init);
> 
> Can I pick up patches 15 and 19, or are there dependencies in the
> series?

Yes, you can pick up patches 15 and 19

> In the latter case,
> Acked-by: Philipp Zabel <p.zabel@pengutronix.de>
> to merge both together with the other patches. Currently there is no
> conflict with changes queued from the reset tree.
> 
> regards
> Philipp
> 

Thanks

Patrice
