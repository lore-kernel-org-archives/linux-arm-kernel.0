From: f.fainelli@gmail.com (Florian Fainelli)
Date: Wed, 27 May 2015 10:33:31 -0700
Subject: [patch -next] ARM: BCM63xx: fix an error path in
 bcm63xx_pmb_power_on_cpu()
In-Reply-To: <20150527082512.GC19423@mwanda>
References: <20150527082512.GC19423@mwanda>
Message-ID: <5565FFEB.7090207@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27/05/15 01:25, Dan Carpenter wrote:
> We need to unlock and unmap some resourses before returning.
> 
> Fixes: 3f2a43c98d72 ('ARM: BCM63xx: Add secondary CPU PMB initialization sequence')
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Applied to bcm/soc, thanks Dan!
-- 
Florian
