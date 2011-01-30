From: jh80.chung@samsung.com (Jaehoon Chung)
Date: Sun, 30 Jan 2011 17:23:43 +0900
Subject: [PATCH 0/5] mmc: add double buffering for mmc block requests
In-Reply-To: <AANLkTi=H71TQpuBnagMThcv-6NKJyqsD-xtg_eW8Pb_T@mail.gmail.com>
References: <1294856043-13447-1-git-send-email-per.forlin@linaro.org>
	<4D34FC5D.5080605@samsung.com>
	<AANLkTimjfO4Wb0f87X_sDugW=yU1=YEQn35uZnsKKwq2@mail.gmail.com>
	<AANLkTi=H71TQpuBnagMThcv-6NKJyqsD-xtg_eW8Pb_T@mail.gmail.com>
Message-ID: <4D45200F.9090007@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Per.

If you sketch a implementation for sdhci. i can test the patches on the Samsung Soc
Your help is very nice for me :).i want to know how much improve the performance 
after applied your patch.

Regards,
Jaehoon Chung

Per Forlin wrote:
> Hi Jaehoon,
> 
> Have you had the chance to test the patches on the Samsung Soc. I can
> sketch a implementation for sdhci if that helps? Unfortunately I don't
> have any hardware to test the SDHCI driver unless there is support in
> QEMU?
> I really think I need to test this on more hardware in order to get
> more results for the patchset and hopefully more attention as well.
> 
> BR
> Per
> 
> On 18 January 2011 09:12, Per Forlin <per.forlin@linaro.org> wrote:
>> On 18 January 2011 03:35, Jaehoon Chung <jh80.chung@samsung.com> wrote:
>>> Hi Per..
>>>
>>> it is interesting approach..so
>>> we want to test your double buffering in our environment(Samsung SoC).
>>>
>>> Did you test with SDHCI?
>> So far I have only tested on mmci for board u5500 and u8500. I happily
>> test on a different board if I can get hold of one.
>>
>>> If you tested with SDHCI, i want to know how much increase the performance.
>>>
>>> Thanks,
>>> Jaehoon Chung
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
