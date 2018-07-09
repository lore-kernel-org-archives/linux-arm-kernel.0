From: f.fainelli@gmail.com (Florian Fainelli)
Date: Mon, 9 Jul 2018 10:40:49 -0700
Subject: [PATCH v4 5/6] arm64: dt: set initial SR watchdog timeout to 60
 seconds
In-Reply-To: <1527530497-10392-6-git-send-email-ray.jui@broadcom.com>
References: <1527530497-10392-1-git-send-email-ray.jui@broadcom.com>
 <1527530497-10392-6-git-send-email-ray.jui@broadcom.com>
Message-ID: <12894566-960c-6d62-539b-2e4f09cce366@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 05/28/2018 11:01 AM, Ray Jui wrote:
> Set initial Stingray watchdog timeout to 60 seconds
> 
> By the time when the userspace watchdog daemon is ready and taking
> control over, the watchdog timeout will then be reset to what's
> configured in the daemon
> 
> Signed-off-by: Ray Jui <ray.jui@broadcom.com>
> Reviewed-by: Vladimir Olovyannikov <vladimir.olovyannikov@broadcom.com>
> Reviewed-by: Scott Branden <scott.branden@broadcom.com>

Applied to devicetree-arm64/next, thanks!
-- 
Florian
