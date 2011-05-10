From: rubini@unipv.it (Alessandro Rubini)
Date: Tue, 10 May 2011 09:39:30 +0200
Subject: [PATCH 08/13] clocksource: convert ARM 32-bit down counting
	clocksources
In-Reply-To: <E1QJhPM-0000yq-ED@rmk-PC.arm.linux.org.uk>
References: <E1QJhPM-0000yq-ED@rmk-PC.arm.linux.org.uk>
	<20110510072700.GA29869@n2100.arm.linux.org.uk>
Message-ID: <20110510073930.GA19558@mail.gnudd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Convert MXC, Nomadik and Orion 32-bit down-counting clocksources to
> generic mmio clocksource infrastructure.

Ok, but I think Linusw should ack this as there is the issue of
dummy-read used initially, that I really didn't understand.

> +	if (clocksource_mmio_init(mti_base + MTU_VAL(0), "mtu_0",

Typo. That's "mtu_base", not "mti".

/alessandro
