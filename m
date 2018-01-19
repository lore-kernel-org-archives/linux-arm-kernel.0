From: shiju.jose@huawei.com (Shiju Jose)
Date: Fri, 19 Jan 2018 15:09:54 +0000
Subject: [1/3] arm64: defconfig: enable CONFIG_ACPI_APEI_MEMORY_FAILURE
In-Reply-To: <CAK8P3a1qYJ5C=rbFWMEompKMbcJfZKTdkxrOcUs1DSQLA6Th1Q@mail.gmail.com>
References: <9fdbf03c-1e70-fc45-b218-404294d4bdb1@huawei.com>
 <67045853-42e1-8246-8789-309d1d233659@codeaurora.org>
 <CAK8P3a1qYJ5C=rbFWMEompKMbcJfZKTdkxrOcUs1DSQLA6Th1Q@mail.gmail.com>
Message-ID: <86258A5CC0A3704780874CF6004BA8A64EDC5C93@FRAEML521-MBX.china.huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks Arnd.

Regards,
Shiju

> -----Original Message-----
> From: arndbergmann at gmail.com [mailto:arndbergmann at gmail.com] On Behalf
> Of Arnd Bergmann
> Sent: 19 January 2018 15:07
> To: Timur Tabi
> Cc: Shiju Jose; Linux ARM; Linux Kernel Mailing List; Catalin Marinas;
> Will Deacon; Gregory CLEMENT; xuwei (O); Olof Johansson; Masahiro
> Yamada; Rob Herring; Heiko Stuebner; Krzysztof Kozlowski; Ard
> Biesheuvel; tbaicar at codeaurora.org; Linuxarm; Zhengqiang (turing)
> Subject: Re: [1/3] arm64: defconfig: enable
> CONFIG_ACPI_APEI_MEMORY_FAILURE
> 
> On Tue, Jan 16, 2018 at 5:10 PM, Timur Tabi <timur@codeaurora.org>
> wrote:
> > On 01/16/2018 09:45 AM, shiju.jose at huawei.com wrote:
> >>
> >> Enable ACPI APEI MEMORY FAILURE option for ARM64, so that memory
> >> errors will be handled.
> >>
> >> Signed-off-by: Shiju Jose<shiju.jose@huawei.com>
> >
> >
> > All three patches:
> >
> > Acked-by: Timur Tabi <timur@codeaurora.org>
> >
> > QDT definitely would like to see these patches merged into 4.16.
> 
> Applied all three to next/soc with your ack, thanks!
> 
> Shiju, there was a small problem with the second patch, which did not
> apply cleanly, but I fixed it up. It might have been easier to get a
> pull request through Wei Xu for this, and it would also help to send
> things a lot earlier rather than just before the merge window.
> 
>       Arnd
