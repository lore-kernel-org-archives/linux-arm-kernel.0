From: f.fainelli@gmail.com (Florian Fainelli)
Date: Fri, 10 Apr 2015 12:50:29 -0700
Subject: [PATCH soc] ARM: BCM5301X: Ignore another (BCM4709 specific)
 fault code
In-Reply-To: <1423669258-27449-1-git-send-email-zajec5@gmail.com>
References: <1423669258-27449-1-git-send-email-zajec5@gmail.com>
Message-ID: <55282985.6070009@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/02/15 07:40, Rafa? Mi?ecki wrote:
> Broadcom ARM devices seem to generate some fault once per boot. We
> already have an ignoring handler for BCM4707/BCM4708, but BCM4709
> generates different code.
> 
> Signed-off-by: Rafa? Mi?ecki <zajec5@gmail.com>

Applied to platform/next, sorry for the lag, thanks!
-- 
Florian
