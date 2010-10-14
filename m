From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Thu, 14 Oct 2010 10:07:22 +0900
Subject: [PATCH 2/3] ARM: S5PV210: Add init code of audio to Goni and
	Aquila board
In-Reply-To: <003701cb6b37$4c106fb0$e4314f10$%kim@samsung.com>
References: <4CA5623B.5030405@samsung.com>
	<003701cb6b37$4c106fb0$e4314f10$%kim@samsung.com>
Message-ID: <AANLkTimwNprWtZiMnAt2-fYGwRySs-mbxxh-TYSqh=f6@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 14, 2010 at 9:32 AM, Kukjin Kim <kgene.kim@samsung.com> wrote:
> Chanwoo Choi wrote:
>>
>> This patch add initializtion code of audio and I2S platform drivers
>> to Goni and Aquila board.

GONI and AQUILA are mostly similar devices with different CPUs.
I have already merged the ASoC machine drivers for them into one.
Maybe you could compress code for other susystems as well ?
