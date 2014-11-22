From: klightspeed@killerwolves.net (Ben Peddell)
Date: Sat, 22 Nov 2014 13:10:21 +1000
Subject: [PATCHv6 10/10] arm: mvebu: add .dts file for Synology DS414
In-Reply-To: <5b678d6d1f2f42f4bf0d087878b9d8024d463ea7.1416613429.git.arno@natisbad.org>
References: <cover.1416613429.git.arno@natisbad.org>
 <5b678d6d1f2f42f4bf0d087878b9d8024d463ea7.1416613429.git.arno@natisbad.org>
Message-ID: <546FFE9D.2000502@killerwolves.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22/11/14 09:46, Arnaud Ebalard wrote:
> +
> +	syno_id_bit0_pin: syno-id-bit0-pin {
> +		marvell,pins = "mpp26";
> +		marvell,function = "gpio";
> +	};
> +
> +	pmx_syno_id_bit1: syno-id-bit1-pin {
> +		marvell,pins = "mpp28";
> +		marvell,function = "gpio";
> +	};
> +
> +	pmx_syno_id_bit2: syno-id-bit2-pin {
> +		marvell,pins = "mpp29";
> +		marvell,function = "gpio";
> +	};
> +
> +	pmx_fan1_alarm: fan1-alarm-pin {
> +		marvell,pins = "mpp33";
> +		marvell,function = "gpio";
> +	};

It looks like you forgot to replace pmx_* with *_pin here.

> +
> +	fan2_alarm_pin: fan2-alarm-pin {
> +		marvell,pins = "mpp32";
> +		marvell,function = "gpio";
> +	};
> +};
> 
