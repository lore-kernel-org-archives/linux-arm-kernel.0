From: sebastien.szymanski@armadeus.com (=?UTF-8?Q?S=c3=a9bastien_Szymanski?=)
Date: Tue, 13 Sep 2016 13:52:48 +0200
Subject: [PATCH v2 1/2] ARM: dts: imx6ul: Add DTS for liteSOM module
In-Reply-To: <20160913094951.26394-1-m.niestroj@grinn-global.com>
References: <20160913094951.26394-1-m.niestroj@grinn-global.com>
Message-ID: <5c6db9d0-e7b2-e3fd-11e6-be1bde6e65e7@armadeus.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On 09/13/2016 11:49 AM, Marcin Niestroj wrote:

> +
> +&cpu0 {
> +	arm-supply = <&reg_arm>;
> +	soc-supply = <&reg_soc>;
> +};

These supplies are already set in the imx6ul.dtsi file.

Regards,

-- 
S?bastien Szymanski
