From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 8 Nov 2011 14:19:10 +0100
Subject: [PATCH 1/3] ARM: AT91: Add platform data for the ADCs
In-Reply-To: <1320682113-23655-2-git-send-email-maxime.ripard@free-electrons.com>
References: <1319041134-19712-1-git-send-email-maxime.ripard@free-electrons.com>
 <1320682113-23655-1-git-send-email-maxime.ripard@free-electrons.com>
 <1320682113-23655-2-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20111108141910.53f6b861@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le Mon,  7 Nov 2011 17:08:31 +0100,
Maxime Ripard <maxime.ripard@free-electrons.com> a ?crit :

> +/* ADC */
> +struct at91_adc_data {
> +	/* ADC Clock as specified by the datasheet, in Hz. */
> +	unsigned int adc_clock;
> +	/*
> +	 * Global number of channels available (to specify which channels are
> +	 * indeed used on the board, see the channels_used array).

channels_used is no longer an array, but a bitmap.

Regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
