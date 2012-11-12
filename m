From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 12 Nov 2012 14:02:47 +0900
Subject: [PATCH 2/2] ARM: S3C64XX: Staticly define parent clock of "camera"
 clock
In-Reply-To: <509EC83D.8010704@gmail.com>
References: <1352556477-3700-1-git-send-email-y@samsung.com>
 <509e6047.a766980a.0f91.14f6@mx.google.com> <509EC391.9090506@gmail.com>
 <509EC83D.8010704@gmail.com>
Message-ID: <004a01cdc092$f57312d0$e0593870$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sylwester Nawrocki wrote:
> 
> On 11/10/2012 10:13 PM, Sylwester Nawrocki wrote:
> > On 11/10/2012 03:07 PM, dron0gus at gmail.com wrote:
> >> From: Andrey Gusakov<dron_gus@mail.ru>
> >>
> >> The "camera" clock have only one parent. Define it staticly and
> 
> Forgot to point out a small typo here: staticly -> statically.
> 
Thanks for pointing out. I fixed it when I applied.

> >> remove unused source clock list.
> >>
> >> Signed-off-by: Andrey Gusakov<dron0gus@gmail.com>
> >
> > Reviewed-by: Sylwester Nawrocki <sylvester.nawrocki@gmail.com>

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
