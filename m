From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 03 Oct 2011 12:27:22 +0900
Subject: [GIT PULL] Samsung devel-2 for v3.2
In-Reply-To: <20111002192950.GB1005@sirena.org.uk>
References: <002001cc80e5$3e497790$badc66b0$%kim@samsung.com>
	<20111002192950.GB1005@sirena.org.uk>
Message-ID: <005801cc817c$5d42f9e0$17c8eda0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark Brown wrote:
> 
> On Sun, Oct 02, 2011 at 06:25:36PM +0900, Kukjin Kim wrote:
> 
> >       gpio/samsung: gpio-samsung.c to support Samsung GPIOs
> 
> As I reported the other day this change breaks the boot early on on the
> Cragganmore S3C6410 based systems (I've not actually fired up my
> SMDK6410 but I suspect it may have issues too).  I did make some brief
> attempts to debug but as there's no console output at all and the diff
> is rather large it's not easy to see what's gone wrong.

Hmm, I thought it has no problem when I saw Thomas Abraham's 'serial:
samsung' patches because he said it works fine with my for-next plus his
patches on SMDK6410...Anyway, I need to sort it out.

Arnd, please hold this on, will request again soon.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
