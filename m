From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 2 Feb 2016 18:34:36 +0000
Subject: [PATCH 07/10] arm64: dts: add the Marvell Armada 3700 family and
 a development board
In-Reply-To: <1454436468-4241-8-git-send-email-gregory.clement@free-electrons.com>
References: <1454436468-4241-1-git-send-email-gregory.clement@free-electrons.com>
 <1454436468-4241-8-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20160202183436.GE29778@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> +	memory {
> +		device_type = "memory";
> +		/* use only 256 MB on the 512 MB available */
> +		reg = <0x00000000 0x00000000 0x00000000 0x10000000>;
> +	};

It would be good to comment as to why we can't use 256M of the memory.

Otherwise this looks fine.

Mark.
