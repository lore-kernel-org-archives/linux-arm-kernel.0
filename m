From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 21 Feb 2013 12:59:26 +0000
Subject: [PATCH 0/3] crypto: sahara: Add support for SAHARA in i.MX27.
In-Reply-To: <1361449162-27302-1-git-send-email-javier.martin@vista-silicon.com>
References: <1361449162-27302-1-git-send-email-javier.martin@vista-silicon.com>
Message-ID: <201302211259.26763.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 21 February 2013, Javier Martin wrote:
> This series of patches provide AES-ECB and AES-CBC support
> for the SAHARA2 cryptographic accelerator which is inside the i.MX27 SoC.
> It is expected that more algorithms will be supported in the future.
> 
> For testing, a Visstrim M10 board has been used and the code related
> to this platform has been included too.

As a new device driver, this needs to be supported on the DT based imx27
machines, while support for the individual board files seems unnecessary.

How about converting the Visstrim M10 board file over to DT so you don't
have to add any more infrastructure for imx that we will just have to
remove again one day?

	Arnd
