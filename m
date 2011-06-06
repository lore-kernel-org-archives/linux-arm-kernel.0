From: green@linuxhacker.ru (Oleg Drokin)
Date: Mon, 6 Jun 2011 13:36:49 -0400
Subject: [PATCH 1/2] cleanup regulator supply definitions in mach-omap2 to
	use REGULATOR_SUPPLY
In-Reply-To: <20110606172832.GM12242@legolas.emea.dhcp.ti.com>
References: <1307342762-25363-1-git-send-email-green@linuxhacker.ru>
	<1307342762-25363-2-git-send-email-green@linuxhacker.ru>
	<20110606092126.GG18731@legolas.emea.dhcp.ti.com>
	<EA5D78AA-5A89-43AC-9D14-F378673F5D41@linuxhacker.ru>
	<20110606171326.GK12242@legolas.emea.dhcp.ti.com>
	<547324C9-4B76-410E-86E6-092D062C95AB@linuxhacker.ru>
	<20110606172832.GM12242@legolas.emea.dhcp.ti.com>
Message-ID: <275EC3C2-501A-4EC4-BFCB-81DBABA49822@linuxhacker.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello!

On Jun 6, 2011, at 1:28 PM, Felipe Balbi wrote:

>> Ok, I get the idea. Do you think it would be best to convert every supply
>> definition to an array then just in case?
> I think that while you're doing this big conversion, why not ?

Well, ok then. I'll redo this patch.

Bye,
    Oleg
