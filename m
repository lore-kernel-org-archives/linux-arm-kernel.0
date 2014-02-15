From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 15 Feb 2014 15:06:42 +0100
Subject: [PATCH v2 00/23] Move DT kirkwood into mach-mvebu
In-Reply-To: <1392459621-24003-1-git-send-email-andrew@lunn.ch>
References: <1392459621-24003-1-git-send-email-andrew@lunn.ch>
Message-ID: <2750178.78BCPXNIeH@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 15 February 2014 11:19:58 Andrew Lunn wrote:
> The process of making most kirkwood boards boot using DT is nearly
> complete. We can now move these boards into mach-mvebu, freeing them
> of the legacy code needed for none-DT systems. At the same time, they
> can become part of ARCH_MULTI_V5.

Great to see this happening at last, great work everyone who was
involved!

Feel free to add 'Acked-by: Arnd Bergmann <arnd@arndb.de>' to all
patches I didn't comment on.

	Arnd
