From: zhangfei.gao@gmail.com (zhangfei gao)
Date: Tue, 7 Jun 2011 13:44:42 +0800
Subject: [PATCH v3 0/3] provide sdhci driver for mmp2 and pxa910
In-Reply-To: <FDBC7F85-3643-4C3C-9E4B-2006D56F24C9@marvell.com>
References: <BANLkTikP72ybaqa8zDgNjBQg8Q6SH5fMdw@mail.gmail.com>
	<FDBC7F85-3643-4C3C-9E4B-2006D56F24C9@marvell.com>
Message-ID: <BANLkTimkk3JfuVmhuBAw4Op93oDtjKdoXw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 4, 2011 at 5:08 AM, Philip Rakity <prakity@marvell.com> wrote:
>
> Please update mmp2 and pxa defconfigs.

The trend is replacing defconfig with device tree, it may not
acceptable to update defconfig.

>
> regards,
>
> Philip
>
> On Jun 3, 2011, at 2:48 AM, zhangfei gao wrote:
>
>> v2->v3, modify according to Arnd and Philip suggestion.
>>
>> Here are patches to provide separate sdhci driver for mmp2 and pxa910
>> based on sdhci-platfm.
>> Rename to sdhci-pxav3.c and sdhci-pxav2.c
>> Remove sdhci-pxa.c, which is used to share among pxa serious, since
>> under this method, platform difference have to be put under arch/arm,
>> which is not easy to track.
>> As a result, mmp2 mmc resource should be updated accordingly.
>
>
