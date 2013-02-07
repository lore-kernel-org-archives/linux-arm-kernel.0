From: grinberg@compulab.co.il (Igor Grinberg)
Date: Thu, 07 Feb 2013 17:32:49 +0200
Subject: [PATCH v2 00/10] rework pxa gpio driver for pinctrl
In-Reply-To: <CAD6h2NSBaQ2SBiqUaxD+oTh9T_UnLKjcGjaqi8n=rts8mOmHmg@mail.gmail.com>
References: <1359886551-20950-1-git-send-email-haojian.zhuang@linaro.org>
 <CACRpkdbNZ4g-beSw=p3v7-QCtLO8sLg__XmhpPLvpvfqDnRLFw@mail.gmail.com>
 <CAD6h2NSBaQ2SBiqUaxD+oTh9T_UnLKjcGjaqi8n=rts8mOmHmg@mail.gmail.com>
Message-ID: <5113C921.5060502@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/06/13 04:08, Haojian Zhuang wrote:
> On 6 February 2013 00:44, Linus Walleij <linus.walleij@linaro.org> wrote:
>> On Sun, Feb 3, 2013 at 11:15 AM, Haojian Zhuang
>> <haojian.zhuang@linaro.org> wrote:
>>
>>> v2:
>>> * Fix the build issue without CONFIG_OF
>>> * Append to check PINCTRL_SINGLE because of arch pxa not moved to DT
>>> * Use bool for inverted, ed_mask, gafr variable
>>
>> Haojian, does this series depend on the changes for DT in pinctrl-single,
>> or can I merge it on its own?
>>
>> The amount of patches makes me confused you know ... :-)
>>
>> Yours,
>> Linus Walleij
> 
> I'm waiting for Igor's test on PXA.
> This patch series is used to support DT better. And the driver still works
> without DT support since there's no DT in PXA chips.

Wait a moment, I have a problem with NFS root:
IP-Config: Failed to open eth0
on both cm_x300 and em_x270.
Both machines use DM9000 and before the series,
the problem does not exist.
I will look into it tomorrow, but I have a feeling that it is related to
the DM9000 interrupt line.

So, please, wait on merging this!


-- 
Regards,
Igor.
