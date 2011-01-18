From: per.forlin@linaro.org (Per Forlin)
Date: Tue, 18 Jan 2011 09:12:24 +0100
Subject: [PATCH 0/5] mmc: add double buffering for mmc block requests
In-Reply-To: <4D34FC5D.5080605@samsung.com>
References: <1294856043-13447-1-git-send-email-per.forlin@linaro.org>
	<4D34FC5D.5080605@samsung.com>
Message-ID: <AANLkTimjfO4Wb0f87X_sDugW=yU1=YEQn35uZnsKKwq2@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18 January 2011 03:35, Jaehoon Chung <jh80.chung@samsung.com> wrote:
> Hi Per..
>
> it is interesting approach..so
> we want to test your double buffering in our environment(Samsung SoC).
>
> Did you test with SDHCI?
So far I have only tested on mmci for board u5500 and u8500. I happily
test on a different board if I can get hold of one.

> If you tested with SDHCI, i want to know how much increase the performance.
>
> Thanks,
> Jaehoon Chung
