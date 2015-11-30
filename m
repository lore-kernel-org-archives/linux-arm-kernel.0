From: tony@atomide.com (Tony Lindgren)
Date: Mon, 30 Nov 2015 13:48:49 -0800
Subject: [PATCH 01/14] ARM: am437x: cm-t43: dts: add basic support for
 sbc-t43
In-Reply-To: <1448371155-17307-2-git-send-email-nikita@compulab.co.il>
References: <1448371155-17307-1-git-send-email-nikita@compulab.co.il>
 <1448371155-17307-2-git-send-email-nikita@compulab.co.il>
Message-ID: <20151130214849.GC23396@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Nikita Kiryanov <nikita@compulab.co.il> [151124 05:20]:
> +&uart0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&uart0_pins_default>;
> +};
> +

Please get rid of the extra line at the end of the file.. It will cause
whitespace warnings when applying and will also cause issues applying
other changes at the end of the file if they rely on the extra line.
And check the whole series, thanks :) It will make my life a bit easier.

And the Subject line should start with "ARM: dts: ..." for the unified
look.

Regards,

Tony
