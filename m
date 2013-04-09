From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 09 Apr 2013 20:20:12 +0900
Subject: [GIT PULL 10/10] devel-samsung for v3.10
In-Reply-To: <51632451.3050801@gmail.com>
References: <51630A55.6030703@samsung.com> <51632451.3050801@gmail.com>
Message-ID: <2f2f01ce3514$33d10f00$9b732d00$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sylwester Nawrocki wrote:

[...]

> > Sylwester Nawrocki (2):
> > ARM: SAMSUNG: Export MIPI CSIS/DSIM PHY control functions
> 
> This one was supposed to be a fix for 3.8-rc IIRC. But anyway the whole

If so, this should be sent to stable 3.8 tree, but I'm not sure this is
really bug fix.

> file this patch touches is going to be removed in 3.11.
> 
It means it is still needed for v3.10 :-)

> > ARM: S3C24XX: Correct NR_IRQS definition for s3c2440
> 
> And this one is needed for 3.9, sorry for not mentioning it in the patch's
> description. Together with [1] it makes my s3c2440 SoC based test board
> booting again with 3.9-rc6.
> 
> [1] http://www.spinics.net/lists/arm-kernel/msg236643.html
> 
OK, let me drop it in this branch.

Arnd and Olof, please hold on pulling for this branch. I will sort out soon.

Thanks.

- Kukjin
