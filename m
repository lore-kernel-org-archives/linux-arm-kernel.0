From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Wed, 06 Jul 2011 10:07:09 +0300
Subject: [PATCH 3/4] MTD: pxa3xx_nand: enable multiple chip select support
In-Reply-To: <CALZhoSSJmcCxEtMXMtfsBKpeOJzqbAt56_RB_Vpqihhuk3Aw=w@mail.gmail.com>
References: <1309319494-17951-1-git-send-email-leiwen@marvell.com>
	<1309771536-10597-4-git-send-email-leiwen@marvell.com>
	<1309935216.3149.72.camel@sauron>
	<CALZhoSSJmcCxEtMXMtfsBKpeOJzqbAt56_RB_Vpqihhuk3Aw=w@mail.gmail.com>
Message-ID: <1309936038.3149.82.camel@sauron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2011-07-06 at 14:54 +0800, Lei Wen wrote:
> On Wed, Jul 6, 2011 at 2:53 PM, Artem Bityutskiy <dedekind1@gmail.com> wrote:
> > The problem is that in this patch you change  struct pxa3xx_nand_platform_data,
> > and in the next patch you amend the platform data declarations, which means that
> > the kernel will not compile between patches 3 and 4...
> 
> So... how about merge the patch 3 and 4 together?

IMO this should be OK.

-- 
Best Regards,
Artem Bityutskiy
