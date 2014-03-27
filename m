From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Thu, 27 Mar 2014 19:02:47 +0100
Subject: [PATCH RFC v3 1/2] clk: Add function parsing arbitrary clock list
 DT property
In-Reply-To: <3164460.aT5tTxdc17@amdc1032>
References: <1395922579-28547-1-git-send-email-s.nawrocki@samsung.com>
 <1395922579-28547-2-git-send-email-s.nawrocki@samsung.com>
 <3164460.aT5tTxdc17@amdc1032>
Message-ID: <533467C7.7020804@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bart,

On 27/03/14 18:17, Bartlomiej Zolnierkiewicz wrote:
>> +struct clk *of_clk_get_by_property(struct device_node *np,
>
> This causes build brake with s3c6400_defconfig
> (it should be 'static inline').

Thanks for reporting it, I assume you meant "build break"? ;)
Will fix that and similar issue in patch 2/2 for next iteration.

--
Regards,
Sylwester
