From: nsekhar@ti.com (Sekhar Nori)
Date: Fri, 10 Jun 2016 18:23:26 +0530
Subject: [PATCH] ARM: davinci: da850: add clocks for mcbsp0 and 1
In-Reply-To: <1462802410-25164-1-git-send-email-petr@barix.com>
References: <1462802410-25164-1-git-send-email-petr@barix.com>
Message-ID: <575AB846.4080608@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 09 May 2016 07:30 PM, Petr Kulhavy wrote:
> Add clock definitions "davinci-mcbsp.0" and "davinci-mcbsp.1" in order
> to make McBSP driver work on the DA850 platform.
> 
> The McBSP 0 and 1 interfaces were not defined for the DA850 platform.
> Neither were the related clocks. In order to make the use of McBSP via
> devicetree the clocks need to be defined.
> 
> Signed-off-by: Petr Kulhavy <petr@barix.com>

Applied to v4.8/soc

Thanks,
Sekhar
