From: broonie@kernel.org (Mark Brown)
Date: Tue, 16 Apr 2013 17:27:50 +0100
Subject: [PATCH v5 3/6] gpio: samsung: Skip legacy GPIO registration if
 pinctrl-s3c64xx is present
In-Reply-To: <1366060483-20342-4-git-send-email-tomasz.figa@gmail.com>
References: <1366060483-20342-1-git-send-email-tomasz.figa@gmail.com>
 <1366060483-20342-4-git-send-email-tomasz.figa@gmail.com>
Message-ID: <20130416162750.GO26958@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 15, 2013 at 11:14:40PM +0200, Tomasz Figa wrote:

>  		{ .compatible = "samsung,exynos4x12-pinctrl", },
>  		{ .compatible = "samsung,exynos5250-pinctrl", },
>  		{ .compatible = "samsung,exynos5440-pinctrl", },
> +		{ },

Strictly speaking this is a separate bug fix (though I see that's
already in -next separately anyway so whatever).
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130416/a1200eaa/attachment.sig>
