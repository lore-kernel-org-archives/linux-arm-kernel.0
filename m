From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Wed, 20 Jul 2011 07:51:47 +0300
Subject: [PATCH V8 0/4] pxa3xx_nand: add two chip select support
In-Reply-To: <1310701473-31632-1-git-send-email-leiwen@marvell.com>
References: <1310481336-13230-1-git-send-email-leiwen@marvell.com>
	<1310701473-31632-1-git-send-email-leiwen@marvell.com>
Message-ID: <1311137512.20738.134.camel@sauron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2011-07-14 at 20:44 -0700, Lei Wen wrote:
> V2:
> Choose to at most keep original pxa3xx_nand_info structure to reduce
> patch size
> 
> V3:
> Seperate original one patch into a patch set
> 
> V4:
> Further seperate patch into small pieces:
> Mainly change make in two patch, which seperate do
> the new structure definition and two chip select support add.
> 
> V5:
> Merge platform change patch and two chip feature into one patch.
> Clean some format issue.
> 
> V6:
> Add suspend and resume enhancement as a part of this patch set.
> 
> V7:
> Fix build bug
> Fix zylonite machine cannot resume back
> 
> V8:
> Fix typos and code style

Pushed the series to the l2-mtd-2.6.git, thanks.

-- 
Best Regards,
Artem Bityutskiy
