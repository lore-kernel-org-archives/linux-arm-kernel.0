From: linux@roeck-us.net (Guenter Roeck)
Date: Wed, 30 Apr 2014 10:06:56 -0700
Subject: [PATCH v2] hwmon: vexpress: Use devm helper for hwmon device
 registration
In-Reply-To: <1398874030-8759-1-git-send-email-pawel.moll@arm.com>
References: <1398874030-8759-1-git-send-email-pawel.moll@arm.com>
Message-ID: <20140430170656.GB3389@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 30, 2014 at 05:07:10PM +0100, Pawel Moll wrote:
> Use devm_hwmon_device_register_with_groups instead of
> the old-style manual attributes and hwmon device registration.
> 
> Also, unroll the attribute group macros for better code
> readability.
> 
> Signed-off-by: Pawel Moll <pawel.moll@arm.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>
