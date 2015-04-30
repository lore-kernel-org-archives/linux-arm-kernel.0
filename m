From: broonie@kernel.org (Mark Brown)
Date: Thu, 30 Apr 2015 19:56:57 +0100
Subject: [PATCH 1/2] Regulator: mc34708: Add DT binding documentation
In-Reply-To: <20150428141738.16243.18377.stgit@localhost>
References: <20150428141736.16243.57292.stgit@localhost>
 <20150428141738.16243.18377.stgit@localhost>
Message-ID: <20150430185657.GB22845@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 28, 2015 at 04:17:38PM +0200, Martin Fuzzey wrote:

> +			pmic_sw3_reg: sw3 {
> +				regulator-name = "SW3";
> +				regulator-min-microvolt = <650000>;
> +				regulator-max-microvolt = <1425000>;
> +			};

These examples look awfully like you're just listiong the maximum range
allowed by the PMIC for all the supplies which is almost never something
someone would want to do on a real board.  Similarly all the names are
just the name of the regulator rather than something that looks like a
board specific name.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150430/f3d90701/attachment-0001.sig>
