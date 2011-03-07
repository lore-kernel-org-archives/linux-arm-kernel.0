From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 07 Mar 2011 15:45:54 +0900
Subject: [PATCH] Exynos4: Remove meaningless REGULATOR config option
In-Reply-To: <20110304124041.GD17653@sirena.org.uk>
References: <20110304051609.GA15121@july> <4D70D295.7030101@ru.mvista.com>
	<20110304124041.GD17653@sirena.org.uk>
Message-ID: <031201cbdc93$510052b0$f300f810$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark Brown wrote:
> 
> On Fri, Mar 04, 2011 at 02:52:53PM +0300, Sergei Shtylyov wrote:
> > On 04-03-2011 8:16, Kyungmin Park wrote:
> 
> >> From: Kyungmin Park<kyungmin.park@samsung.com>
> 
> >> reguration APIs are guarded at its header file
> 
> >    Regulation?
> 
> >> No need to define at codes.
> 
> >    Can't understand this.
> 
> The regulator API ifdefs itself out when not enabled so there is no need
> for users to do this.

Hi Mark and Sergei,

Thanks for your pointing out and suggestion :)

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
