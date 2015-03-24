From: fainelli@broadcom.com (Florian Fainelli)
Date: Tue, 24 Mar 2015 15:14:27 -0700
Subject: [PATCH] ARM: cygnus: fix const declaration bcm_cygnus_dt_compat
In-Reply-To: <1426981535-1800-1-git-send-email-stefan@agner.ch>
References: <1426981535-1800-1-git-send-email-stefan@agner.ch>
Message-ID: <5511E1C3.1090209@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21/03/15 16:45, Stefan Agner wrote:
> The const declaration for char* is actually duplicated, however
> the array of strings is currently not constant. However, typically
> the dt_compat array is declared as const char *const. Follow
> that convention and also add the __initconst macro for constant
> initialization data.
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>

Applied to platform/next, thanks
-- 
Florian
