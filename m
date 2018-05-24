From: ramon.fried@gmail.com (Ramon Fried)
Date: Thu, 24 May 2018 23:17:19 +0300
Subject: uImage target support on arm64
In-Reply-To: <20180524193449.jql27apudwaevwpf@tarshish>
References: <CA+Kvs9=mgW4Z=UcBZZLL82fJ=c--OXF3=B2Zbho+CfMTr8Wk-Q@mail.gmail.com>
 <20180524193449.jql27apudwaevwpf@tarshish>
Message-ID: <CA+Kvs9=x4kxkj-amni+E_KVjH2qjq_mXU88Dr-x5NNyz64gfuA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 24, 2018 at 10:34 PM, Baruch Siach <baruch@tkos.co.il> wrote:
> Hi Ramon,
>
> On Thu, May 24, 2018 at 10:05:15PM +0300, Ramon Fried wrote:
>> I've noticed that it's not supported.
>> Is it on purpose ?
>
> Yes. The 32bit load address in the uImage header in pretty limited when
> applied to 64bit ARM64. Even for ARM zImage is the preferred kernel format for
> quite some time now, since it allows flexible load address, as well as
> multi-platform kernels.
Hi Baruch.
I though that in terms of U-boot, the new FIT image is the preferred
kernel format.
Thanks,
Ramon.
>
>> If not I'll be happy to add support for: make uImage
>> for arm64 targets.
>
> baruch
>
> --
>      http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
> =}------------------------------------------------ooO--U--Ooo------------{=
>    - baruch at tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -
