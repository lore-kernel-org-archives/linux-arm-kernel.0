From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 30 Oct 2015 14:36:01 +0100
Subject: [PATCH] arm64: dts: Added syscon-reboot node for FSL's LS2085A SoC
In-Reply-To: <CY1PR0301MB07480A8EC25BB6987883AE5687220@CY1PR0301MB0748.namprd03.prod.outlook.com>
References: <1445650280-9966-1-git-send-email-German.Rivera@freescale.com>
 <20151027163441.GK3091@leverpostej>
 <CY1PR0301MB07480A8EC25BB6987883AE5687220@CY1PR0301MB0748.namprd03.prod.outlook.com>
Message-ID: <41343887.dUfAz3IhqL@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 27 October 2015 18:25:04 Stuart Yoder wrote:
> I think that comment "Currently supported enable-method is psci v0.2" is a statement of
> intent, not what is available currently.   And the only plan I am aware of is PSCI
> with UEFI based firmware.
> 
> U-boot is a key firmware platform for us and has no PSCI implementation available.

I believe U-boot has supported PSCI since 2013. Maybe you just need to update
to a newer version?

	Arnd
