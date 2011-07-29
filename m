From: nm@ti.com (Menon, Nishanth)
Date: Fri, 29 Jul 2011 18:07:17 -0500
Subject: [RFC/PATCH 2/7] OMAP3: beagle: don't touch omap_device internals
In-Reply-To: <20110729140515.GV31013@legolas.emea.dhcp.ti.com>
References: <1311292338-11830-1-git-send-email-khilman@ti.com>
	<1311292338-11830-4-git-send-email-khilman@ti.com>
	<20110722085716.GI32058@legolas.emea.dhcp.ti.com>
	<20110728055346.GA11921@foobar> <4E315C9F.1030801@ti.com>
	<CAOMWX4fYGD4aRomoHZjvy_F9CRb_U9UV4OOa0BgrzZhx81iQtQ@mail.gmail.com>
	<20110729134932.GA2258@foobar>
	<20110729140515.GV31013@legolas.emea.dhcp.ti.com>
Message-ID: <CAOMWX4e0CODd8YT4LC2zHdGhzzZpOqRc0CU8roV-Pw1VTx5XCw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 29, 2011 at 09:05, Felipe Balbi <balbi@ti.com> wrote:
>
>> +}
>> +EXPORT_SYMBOL(omap_hwmod_name_get_odev);
>
> maybe EXPORT_SYMBOL_GPL() ?? Not sure we want non-GPL code to access
> this ;-)

Sure.. but is this the way we want to go? if yes, I can post the
series in a formal way to the list.

Regards,
Nishanth Menon
