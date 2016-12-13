From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 13 Dec 2016 16:41:37 +0100
Subject: [PATCH v9 2/3] mfd: Kconfig: MFD_SUN4I_GPADC depends on
 !TOUCHSCREN_SUN4I_GPADC
In-Reply-To: <20161213143332.24988-3-quentin.schulz@free-electrons.com>
References: <20161213143332.24988-1-quentin.schulz@free-electrons.com>
 <20161213143332.24988-3-quentin.schulz@free-electrons.com>
Message-ID: <20161213154137.spsu3rnmy3xi3toq@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 13, 2016 at 03:33:31PM +0100, Quentin Schulz wrote:
> MFD_SUN4I_GPADC and TOUCHSCREEN_SUN4I are incompatible (both are drivers
> for Allwinner SoCs' ADC). This makes sure TOUCHSCREEN_SUN4I isn't
> enabled while MFD_SUN4I_GPADC is enabled.
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Thanks,
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161213/eee851ba/attachment-0001.sig>
