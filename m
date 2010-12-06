From: marc@cpdesign.com.au (Marc Reilly)
Date: Tue, 7 Dec 2010 08:54:20 +1100
Subject: [PATCH] support PMIC mc13892
In-Reply-To: <1291616735-29645-1-git-send-email-yong.shen@freescale.com>
References: <1291616735-29645-1-git-send-email-yong.shen@freescale.com>
Message-ID: <201012070854.21049.marc@cpdesign.com.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Monday, December 06, 2010 05:25:35 pm yong.shen at freescale.com wrote:
> From: Yong Shen <yong.shen@linaro.org>
> 
> add support for mc13892, tested on mx51 babbage board
> 

I'd love to test this but our 13892 is connected via I2C, so I guess I'll need 
to modify it a bit to add I2C support. (I don't think the 13873 has I2C 
connectivity though).

I'll let you know how it goes.

Cheers
Marc
