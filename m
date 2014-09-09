From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 09 Sep 2014 17:58:12 +0200
Subject: [PATCH v2 3/8] Documentation: bindings: net: add the Marvell
 PXA168 Ethernet controller
In-Reply-To: <1410273848-24663-4-git-send-email-antoine.tenart@free-electrons.com>
References: <1410273848-24663-1-git-send-email-antoine.tenart@free-electrons.com>
 <1410273848-24663-4-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <3827594.chb831jyvc@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 09 September 2014 16:44:03 Antoine Tenart wrote:
> +- clocks: pointer to the clock for the device.
> +- clock-names: should be "MFUCLK".

Clock names are normally not capitalized. Are you able to change
that name when providing a binding or make it an anoymous clock?
What does MFU stand for anyway?

	Arnd
