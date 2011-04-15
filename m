From: nsekhar@ti.com (Nori, Sekhar)
Date: Fri, 15 Apr 2011 18:28:52 +0530
Subject: [PATCH 1/3] DA8xx: kill duplicate #define DA8XX_GPIO_BASE
In-Reply-To: <201104062124.31206.sshtylyov@ru.mvista.com>
References: <201104062124.31206.sshtylyov@ru.mvista.com>
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024C96087E@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 06, 2011 at 22:54:31, Sergei Shtylyov wrote:
> DA8XX_GPIO_BASE is #define'd in both <mach/da8xx.h> and devices-da8xx.c;
> moreover, it's not even used in the latter file...
> 
> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

Thanks Sergei for the clean-up. Will queue these three for the
next merge window.

Thanks,
Sekhar
