From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 30 Nov 2016 17:52:20 +0100
Subject: [GIT PULL 1/6] Broadcom soc changes for 4.10
In-Reply-To: <20161122054824.16974-1-f.fainelli@gmail.com>
References: <20161122054824.16974-1-f.fainelli@gmail.com>
Message-ID: <23121827.vnVDrZQAeV@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, November 21, 2016 9:48:19 PM CET Florian Fainelli wrote:
> This pull request contains Broadcom ARM-based SoC changes for 4.10, please pull
> the following:
> 
> - Rafal adds back the abort handler hook on BCM5301x which is required to silence
>   errors forwared from the PCIe controller that cannot be silenced at the PCIe RC level
> 

Pulled into next/soc.

It's unclear to me whether we want this to be backported to stable kernels,
can you clarify?

Thanks,

	Arnd
