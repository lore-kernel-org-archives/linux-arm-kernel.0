From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 18 Jul 2018 21:52:43 -0300
Subject: [PATCH] ARM: dts: vf610: Add ZII SSMB SPU3 board
In-Reply-To: <CAHQ1cqG+-7sxJjqs86HG3iOdqDWNQZRpTDTev8XYi2jH=BVFOg@mail.gmail.com>
References: <20180717040651.641-1-andrew.smirnov@gmail.com>
 <CAOMZO5Dp5aTZF0drkD+QSRyX6qGxAe0yeYGUS8-v=FtJwA7=SA@mail.gmail.com>
 <CAHQ1cqG+-7sxJjqs86HG3iOdqDWNQZRpTDTev8XYi2jH=BVFOg@mail.gmail.com>
Message-ID: <CAOMZO5BW8HK1Vbg9Z+mjCk_AZ5aR_q86HOZHY7F-wZQer7H9yQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrey,

On Wed, Jul 18, 2018 at 9:51 PM, Andrey Smirnov
<andrew.smirnov@gmail.com> wrote:

> It's not used in Linux, but I do rely on it in Barebox here:
>
> https://git.pengutronix.de/cgit/barebox/tree/arch/arm/boards/zii-vf610-dev/board.c#n94
>
> and here:
>
> https://git.pengutronix.de/cgit/barebox/tree/arch/arm/boards/zii-vf610-dev/board.c#n137
>
> so it's pretty handy to have. I can remove it if it is too much of an eyesore.

Thanks for the clarification. If you use it in Barebox, then it's fine
to keep it.
