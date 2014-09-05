From: Anson.Huang@freescale.com (Anson.Huang at freescale.com)
Date: Fri, 5 Sep 2014 03:32:14 +0000
Subject: [PATCH 0/3] move gpt per clk parent for ipg_per to OSC
In-Reply-To: <20140905003523.GD10809@dragon>
References: <1409729805-9741-1-git-send-email-b20788@freescale.com>
 <CAOMZO5BOfsvrH3ijxKwyGemEW-B60n-+4wpDZ5xfC98efM469w@mail.gmail.com>
 <20140905003523.GD10809@dragon>
Message-ID: <7e5aa554087e4809895cf7648ac224c0@BN1PR0301MB0628.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Shawn and Fabio
	Thanks for advice, I have sent out V2 patch, please help review.

Best regards!
Anson Huang


-----Original Message-----
From: Shawn Guo [mailto:shawn.guo at freescale.com] 
Sent: 2014-09-05 8:35 AM
To: Fabio Estevam
Cc: Huang Yongcai-B20788; Sascha Hauer; devicetree at vger.kernel.org; linux-arm-kernel at lists.infradead.org
Subject: Re: [PATCH 0/3] move gpt per clk parent for ipg_per to OSC

On Thu, Sep 04, 2014 at 07:50:35PM -0300, Fabio Estevam wrote:
> This patch series works fine if we use the new dtb and new kernel.
> 
> However, booting a kernel with these series applied and using an old 
> dtb we get a system with broken timer.
> 
> 'sleep 1' takes something like 20 seconds in this case.

Oh, yes.  It breaks the compatibility with existing DTB.  Dropped the patches for now.

Anson,

We may need to query the clock rate and then decide how to set up those register bits?

Shawn
