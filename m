From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 17 Nov 2012 15:45:21 +0000
Subject: [PATCH v3 00/18] ARM: Patchset for CLPS711X
In-Reply-To: <1353160644-22446-1-git-send-email-shc_work@mail.ru>
References: <1353160644-22446-1-git-send-email-shc_work@mail.ru>
Message-ID: <201211171545.22154.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 17 November 2012, Alexander Shiyan wrote:
> Here is a v3 patchset for a CLPS711X-target.
> The main direction of this patchset - approaching the platform to the
> possibility of using configurations with multiple platforms in a single
> kernel. Added support of the majority of the necessary kernel symbol.
> Also part of the driver code used only for the platform was moved to the
> board code and converted to the use of standard drivers.
> 

(+Linus Walleij)

Thanks for sending the new version, as discussed on IRC. It's important
to mention here that the series depends on patches that Linus applied into
the gpio tree. Olof, if you merge these before I get to it, please apply
them on top of an appropriate branch from the GPIO tree. Linus, is
2cad6a8a4c an appropriate commit to base on? I think that is the
olders one that can be used as a base here.

	Arnd
