From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Sun, 27 Nov 2016 20:22:06 +0100
Subject: [PATCH v5 2/2] ARM: dts: add support for Turris Omnia
In-Reply-To: <20161125142658.21690-3-uwe@kleine-koenig.org>
References: <20161125142658.21690-1-uwe@kleine-koenig.org>
 <20161125142658.21690-3-uwe@kleine-koenig.org>
Message-ID: <71af60f5-b657-cab4-32a8-00a604fc656e@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 25.11.2016 um 15:26 schrieb Uwe Kleine-K?nig:
> diff --git a/arch/arm/boot/dts/armada-385-turris-omnia.dts b/arch/arm/boot/dts/armada-385-turris-omnia.dts
> new file mode 100644
> index 000000000000..bcc10c285889
> --- /dev/null
> +++ b/arch/arm/boot/dts/armada-385-turris-omnia.dts
[...]
> +	chosen {
> +		stdout-path = &uart0;
> +	};

I notice that the other 38x boards (and thus my previous Omnia .dts) use
"serial0:115200n8". Can we really rely on the driver defaults here?

Regards,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
