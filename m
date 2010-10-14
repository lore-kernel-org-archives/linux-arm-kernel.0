From: kyungmin.park@samsung.com (Kyungmin Park)
Date: Thu, 14 Oct 2010 10:13:23 +0900
Subject: [PATCH 2/3] ARM: S5PV210: Add init code of audio to Goni and
	Aquila board
In-Reply-To: <AANLkTimwNprWtZiMnAt2-fYGwRySs-mbxxh-TYSqh=f6@mail.gmail.com>
References: <4CA5623B.5030405@samsung.com>
	<003701cb6b37$4c106fb0$e4314f10$%kim@samsung.com>
	<AANLkTimwNprWtZiMnAt2-fYGwRySs-mbxxh-TYSqh=f6@mail.gmail.com>
Message-ID: <AANLkTimqBgUuVzhV84HKGUygNB2raebrgTrEeKnd3uQc@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 14, 2010 at 10:07 AM, Jassi Brar <jassisinghbrar@gmail.com> wrote:
> On Thu, Oct 14, 2010 at 9:32 AM, Kukjin Kim <kgene.kim@samsung.com> wrote:
>> Chanwoo Choi wrote:
>>>
>>> This patch add initializtion code of audio and I2S platform drivers
>>> to Goni and Aquila board.
>
> GONI and AQUILA are mostly similar devices with different CPUs.
> I have already merged the ASoC machine drivers for them into one.
> Maybe you could compress code for other susystems as well ?
It's not exactly. GPIO pins are different.

Thank you,
Kyungmin Park
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
