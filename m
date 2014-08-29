From: naveenkrishna.ch@gmail.com (Naveen Krishna Ch)
Date: Fri, 29 Aug 2014 11:16:35 +0530
Subject: [PATCH 10/14] arm64: dts: add pinctrl support to EXYNOS7
In-Reply-To: <53FDBD7E.3050102@samsung.com>
References: <1409132660-1898-1-git-send-email-ch.naveen@samsung.com>
 <1409132660-1898-2-git-send-email-ch.naveen@samsung.com>
 <53FDBD7E.3050102@samsung.com>
Message-ID: <CAHfPSqBja8z6TLaLoyAYJ33pmNC-FdMEphmdL5UB9p_k1CG_tQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Tomasz,

On 27 August 2014 16:44, Tomasz Figa <t.figa@samsung.com> wrote:
> Hi Naveen,
>
> Please see my comments inline.
>
> On 27.08.2014 11:44, Naveen Krishna Chatradhi wrote:
>> Add the required pin configuration support to EXYNOS7
>
> [snip]
>
>> +/ {
>> +     /* ALIVE block @10580000 */
>> +     pinctrl at 10580000 {
>
> This syntax repeating the whole hierarchy of nodes in every dts file is
> considered obsolete in case of Exynos DT sources. Please switch to
> reference-based one. Please see related files for Exynos5260 and 5800 as
> examples.

Sure, will respin with reference based usage.
>
> [snip]
>
>> +             disp_teson: disp_teson {
>> +                     samsung,pins = "gpg0-1";
>> +                     samsung,pin-function = <2>;
>> +             };
>> +
>> +             disp_tesoff: disp_tesoff {
>> +                     samsung,pins = "gpg0-1";
>> +                     samsung,pin-function = <0>;
>
> This is not a special function, so I don't think it belongs to this file.
>
> Best regards,
> Tomasz

Thanks for the in depth review.
Will fixes the comments.


-- 
Thanks & Regards,
(: Nav :)
