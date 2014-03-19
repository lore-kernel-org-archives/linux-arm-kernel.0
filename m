From: emilio@elopez.com.ar (=?UTF-8?B?RW1pbGlvIEzDs3Bleg==?=)
Date: Wed, 19 Mar 2014 17:01:54 -0300
Subject: [PATCH 1/4] clk: sunxi: fix A20 PLL4 calculation
In-Reply-To: <20140319194213.30995.52897@quantum>
References: <1395253173-30437-1-git-send-email-emilio@elopez.com.ar>
 <1395253173-30437-2-git-send-email-emilio@elopez.com.ar>
 <20140319194213.30995.52897@quantum>
Message-ID: <5329F7B2.6000205@elopez.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike,

El 19/03/14 16:42, Mike Turquette escribi?:
> Quoting Emilio L?pez (2014-03-19 11:19:30)
>> Allwinner actually reworked the PLL4 on A20; now it's compatible with
>> the sun4i PLL5/6 design previous to any divisions, as well as to the new
>> PLL8 in sun7i.
>>
>> Signed-off-by: Emilio L?pez <emilio@elopez.com.ar>
>
> Trivial merge conflict after applying this patch on top of your 3.15
> pull request. My resolution is below. Let me know if I've made a
> mistake.

Looks good to me.

Thanks!

Emilio
