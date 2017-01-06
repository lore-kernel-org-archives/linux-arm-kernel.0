From: andi.shyti@samsung.com (Andi Shyti)
Date: Fri, 06 Jan 2017 16:59:14 +0900
Subject: [PATCH v3 2/5] arm64: dts: exynos: make tm2 and tm2e independent
 from each other
In-Reply-To: <20170106070911.sj6qjd5akyxnazsl@kozik-lap>
References: <1483675149-32598-1-git-send-email-jcsing.lee@samsung.com>
 <CGME20170106035914epcas5p209490dfca8e8ae83c6a9b5aa1408a1ed@epcas5p2.samsung.com>
 <1483675149-32598-3-git-send-email-jcsing.lee@samsung.com>
 <20170106070911.sj6qjd5akyxnazsl@kozik-lap>
Message-ID: <20170106075914.y5nuak3bz3zrvvex@gangnam.samsung>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, 

On Fri, Jan 06, 2017 at 09:09:11AM +0200, Krzysztof Kozlowski wrote:
> On Fri, Jan 06, 2017 at 12:59:06PM +0900, Jaechul Lee wrote:
> > From: Andi Shyti <andi.shyti@samsung.com>
> > 
> > Currently tm2e dts includes tm2 but there are some differences
> > between the two boards and tm2 has some properties that tm2e
> > doesn't have.
> > 
> > That's why it's important to keep the two dts files independent
> > and put all the commonalities in a tm2-common.dtsi file.
> > 
> > At the current status the only two differences between the two
> > dts files (besides the board name) are ldo31 and ldo38.
> > 
> > Signed-off-by: Andi Shyti <andi.shyti@samsung.com>
> > Signed-off-by: Jaechul Lee <jcsing.lee@samsung.com>
> > ---
> >  .../boot/dts/exynos/exynos5433-tm2-common.dtsi     | 1118 +++++++++++++++++++
> >  arch/arm64/boot/dts/exynos/exynos5433-tm2.dts      | 1153 +-------------------
> 
> Like talking to a wall. Without any feedback. If my instructions were
> wrong (and it is not possible to detect rename) then please say it (you
> can add personal comments after separator ---).

no Krzysztof, I'm sorry, but this patch has been formatted with
the diff algorithm *you* asked, -B50% both version 2 (where you
didn't comment) and version 3. If you still don't like it, please
don't blame me, blame the algorithm.

Now we can stay here at trying random diff algorithms (as they
give more or less the same result) or you tell me which exact
algorithm you want me to use. Besides, for me it's clear,
tm2-common is all new, while in tm2 you have on one side the '-'
(if it applies nothing has changed) on the bottom the '+'.

Andi
