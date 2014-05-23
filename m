From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 23 May 2014 12:43:41 +0100
Subject: [PATCH] mfd: axp20x: Remove unnecessary const qualifier from
 axp20x_supplies[]
In-Reply-To: <1400777136.21099.6.camel@joe-AO725>
References: <1400750311-15323-1-git-send-email-lee.jones@linaro.org>
 <1400750311-15323-2-git-send-email-lee.jones@linaro.org>
 <1400774373.21099.1.camel@joe-AO725>
 <20140522160856.GJ19747@lee--X1>
 <1400777136.21099.6.camel@joe-AO725>
Message-ID: <20140523114341.GX19747@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > To be frank, I've never known what the double const means.  Care to
> > enlighten?
> 
> There's a nice table here:
> 
> http://stackoverflow.com/questions/14562845/why-does-passing-char-as-const-char-generate-a-warning

Okay, I get it. I think you're right, I'll make the change and see
what else breaks and try to fix that too.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
