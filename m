From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Tue, 28 Mar 2017 13:14:27 +0300
Subject: [PATCH v4 0/6] Pad retentions support for Exynos5433
In-Reply-To: <CACRpkdY1snu8tNaUW4hR7zvMSMv10wUoeAnv28Ag=NJuHAS-Pw@mail.gmail.com>
References: <CGME20170323080346eucas1p216eec41325d220774ecec05b397e83a6@eucas1p2.samsung.com>
 <1490256207-10061-1-git-send-email-m.szyprowski@samsung.com>
 <CACRpkdY1snu8tNaUW4hR7zvMSMv10wUoeAnv28Ag=NJuHAS-Pw@mail.gmail.com>
Message-ID: <CAJKOXPc7bmAFjqS59Tqm=-vqMpC8-w0KsmabZDZZLN13h593CQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 28, 2017 at 12:22 PM, Linus Walleij
<linus.walleij@linaro.org> wrote:
> On Thu, Mar 23, 2017 at 9:03 AM, Marek Szyprowski
> <m.szyprowski@samsung.com> wrote:
>
>> This patchset is a next step to add support for all power domains on
>> Exynos5433 SoCs. This patchset contains patches for Exynos pin control
>> driver and Exynos LPASS MFD driver, which are needed to make the
>> platform ready for adding power domains support.
>>
>> Patches in this patchset have runtime dependency. They are order in such
>> a way to make the changes bisectable (mfd lpass changes should be applied
>> after pinctrl patches). Other dependencies mentioned previously in v3 of
>> this patchset has been finally merged to v4.11-rc1.
>>
>> Patches have been rebased on top of linux v4.11-rc3.
>
> Pinctrl development is based on -rc1.
>
> I expect Krzysztof to figure out and apply the patches to his Samsung pinctrl
> branch and forward to me, all looks OK to me.

Yes, I already have them:
https://git.kernel.org/pub/scm/linux/kernel/git/pinctrl/samsung.git/log/?h=pinctrl-next

However this reminds me to prepare a pull request for mfd tree because
they base on top of it.

Best regards,
Krzysztof
