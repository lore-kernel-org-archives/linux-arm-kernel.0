From: khilman@ti.com (Kevin Hilman)
Date: Wed, 05 Oct 2011 12:04:54 -0700
Subject: [PATCH v6 07/16] OMAP2+: UART: Add default mux for all uarts.
In-Reply-To: <1317380495-584-7-git-send-email-govindraj.raja@ti.com>
	(Govindraj R.'s message of "Fri, 30 Sep 2011 16:31:33 +0530")
References: <1317380495-584-1-git-send-email-govindraj.raja@ti.com>
	<1317380495-584-7-git-send-email-govindraj.raja@ti.com>
Message-ID: <87zkhf9s4p.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

"Govindraj.R" <govindraj.raja@ti.com> writes:

> Prior to this change rx-pad wakeup was done by writing to rx-pad offset value
> populated in serial.c idle_init. Now with mux framework support we can use
> mux_utilities along with hmwod framework to handle io-pad configuration and
> enable rx-pad wake-up mechanism.

This patch (along with a few others) have compile errors when CONFIG_PM
is not set.

Kevin
