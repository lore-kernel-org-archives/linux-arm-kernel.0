From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 15 Sep 2016 13:33:15 +0200
Subject: [PATCH 6/7] mfd: omap-usb-host: Return value is not 'const int'
In-Reply-To: <20160915104521.14286-7-lee.jones@linaro.org>
References: <20160915104521.14286-1-lee.jones@linaro.org>
 <20160915104521.14286-7-lee.jones@linaro.org>
Message-ID: <10017561.lkNHAJAJWE@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, September 15, 2016 11:45:20 AM CEST Lee Jones wrote:
> Change from 'const int' to just 'int'.
> 
> Cc: <robh+dt@kernel.org>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> 

Looks good, I seem to have done the same thing. Also didn't submit,
so keep your version.

I tend to include the exact warning in the changelog, which here was

drivers/mfd/omap-usb-host.c:165:18: warning: type qualifiers ignored on function return type [-Wignored-qualifiers]

	Arnd
