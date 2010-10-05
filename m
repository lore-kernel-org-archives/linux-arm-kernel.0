From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 05 Oct 2010 17:40:07 +0900
Subject: [PATCH 0/7] ARM: S5PC210: I2C devices support and Universal board
	updates
In-Reply-To: <AANLkTiknkbts6AtiBpqceSDqEXsE9E+qpMKJx2fzygB6@mail.gmail.com>
References: <20100930044814.GA16892@july>
	<AANLkTiknkbts6AtiBpqceSDqEXsE9E+qpMKJx2fzygB6@mail.gmail.com>
Message-ID: <001401cb6468$ed8d06d0$c8a71470$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kyungmin Park wrote:
> 
> Hi,
> 
Hi,

> I think we made some conclusion. first apply the current style and
> improve it later for consistency.
> 
Yeah, we should decide for this.

However, it's expected following problem with current I2C style.

Suppose A board want to use only I2C0, 1, 2, 3, 4, 7 as I2C and B board want
to use all of I2C channels as I2C. If use one kernel image for A and B,
maybe selected all I2C channels. It can be happened the some problem about
I2C5 and I2C6 on A board when it used for other purpose.

Of course can happen regardless of number of I2C channel, but if more I2C
channels, the probability can be increased.

Anyway I know Mr. Han is preparing I2C patches for it and almost done.
How about continuing discussion for this after submitting it?

I think we have some time that talk about this issue.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
