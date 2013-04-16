From: broonie@kernel.org (Mark Brown)
Date: Tue, 16 Apr 2013 17:26:43 +0100
Subject: [PATCH v5 2/6] ARM: s3c64xx: Skip legacy EINT setup if
 pinctrl-s3c64xx driver is present
In-Reply-To: <1366060483-20342-3-git-send-email-tomasz.figa@gmail.com>
References: <1366060483-20342-1-git-send-email-tomasz.figa@gmail.com>
 <1366060483-20342-3-git-send-email-tomasz.figa@gmail.com>
Message-ID: <20130416162642.GN26958@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 15, 2013 at 11:14:39PM +0200, Tomasz Figa wrote:

> +	* This gpio driver includes support for device tree support and there
> +	* are platforms using it. In order to maintain compatibility with those
> +	* platforms, and to allow non-dt Exynos4210 platforms to use this
> +	* gpiolib support, a check is added to find out if there is a active

Cut'n'paste error here.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130416/32076ae8/attachment.sig>
