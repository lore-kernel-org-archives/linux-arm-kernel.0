From: festevam@gmail.com (Fabio Estevam)
Date: Sun, 25 Oct 2015 19:37:15 -0200
Subject: [PATCH V2 06/11] mmc: sdhci-esdhc-imx: fix cd regression for dt
 platform
In-Reply-To: <CAOCHtYj1QuEYLg4vbxshWkYXPe6r9b5OP7hh_O0WoE6xfL0mjw@mail.gmail.com>
References: <1437569590-5228-1-git-send-email-aisheng.dong@freescale.com>
 <1437569590-5228-7-git-send-email-aisheng.dong@freescale.com>
 <2333b5f060a8e45bd8adcdab55365fab@agner.ch>
 <CAOMZO5BUKmqczyVgz_WgYmBMeuGugDS4uVjw+LXebxf-nPDTyw@mail.gmail.com>
 <CAOMZO5Dz0KijjryoPihoXsP4b5Wy_5rock++oY=i-9gESThUbg@mail.gmail.com>
 <CAOCHtYgayRZoHxJ2d8f1mO0QW_=N4Mx2_RSCrADKERHdP9TGYQ@mail.gmail.com>
 <CAOMZO5D2LNS93XVx86fL7oLTgy4apU036v-ohhv-=kw5gFsCww@mail.gmail.com>
 <CAOCHtYj1QuEYLg4vbxshWkYXPe6r9b5OP7hh_O0WoE6xfL0mjw@mail.gmail.com>
Message-ID: <CAOMZO5Cuu2B=s8UPQP1+VLzgFL99FYiw=mgYX+Jfi3g7c-ABOQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 25, 2015 at 7:33 PM, Robert Nelson <robertcnelson@gmail.com> wrote:
> On Sun, Oct 25, 2015 at 4:05 PM, Fabio Estevam <festevam@gmail.com> wrote:
>> On Sun, Oct 25, 2015 at 6:52 PM, Robert Nelson <robertcnelson@gmail.com> wrote:
>>
>>> I need to finish a full bisect run, but one of these sdhci-esdhci-imx
>>> fixes broke the wandboard..
>>
>> Could you please try to apply the attached patch?
>>
>> Looks like this one was not applied.
>
> Thanks Fabio, that fixes the regression on v4.1.11 on my wand's... Too
> bad it's also not in:
>
> https://lkml.org/lkml/2015/10/23/516

This is strange. I have an automatic email from Greg in my Inbox
saying that the mx6 patch has been applied to stable, but for some
reason it was not applied.

I will ask Greg if I need to resend it.

Thanks for reporting it.
