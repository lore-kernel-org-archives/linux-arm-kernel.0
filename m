From: f.fainelli@gmail.com (Florian Fainelli)
Date: Sun, 13 Nov 2016 22:10:55 -0800
Subject: [PATCH 09/16] ARM: BCM: use generic API for enabling SCU
In-Reply-To: <1479099731-28108-10-git-send-email-pankaj.dubey@samsung.com>
References: <1479099731-28108-1-git-send-email-pankaj.dubey@samsung.com>
 <1479099731-28108-10-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <7cdf4e03-98c8-430c-b5cb-3a5c4c13d7d3@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 13/11/2016 ? 21:02, Pankaj Dubey a ?crit :
> Now as we have of_scu_enable which takes care of mapping
> scu base from DT, lets use it.
> 
> CC: Florian Fainelli <f.fainelli@gmail.com>
> CC: Ray Jui <rjui@broadcom.com>
> CC: Scott Branden <sbranden@broadcom.com>
> CC: bcm-kernel-feedback-list at broadcom.com
> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>

Let me know if I need to pick this and submit via ARM SoC pull requests,
thanks!
-- 
Florian
