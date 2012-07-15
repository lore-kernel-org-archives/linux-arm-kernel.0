From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 15 Jul 2012 19:59:19 +0000
Subject: [PATCH 0/8] ARM: support for Moschip MCS814x SoCs
In-Reply-To: <1342363754-30808-1-git-send-email-florian@openwrt.org>
References: <1342363754-30808-1-git-send-email-florian@openwrt.org>
Message-ID: <201207151959.19620.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 15 July 2012, Florian Fainelli wrote:
> This patchset adds basic support for Mocship MCS814x, and in particular
> MCS8140, and allows one booting to user space. Two off-the-shelf boards
> are support: Tigal/Robotech RBT-832 and Devolo dLAN USB Extender.
> 
> Support for other on-board peripherals will obviously be contributed later
> once the basic SoC support has been accepted.

Hi Florian,

This looks quite nice at first sight, but I have to say that your timing
is rather unfortunate. We're getting rather close to the 3.6 merge window,
so there is not much time to review the platform thoroughly before that
and I'd feel more comfortable about putting it into 3.7. I'll let others
weigh in, too. At least there is no risk of regressions for a new platform
getting added, so if other people think we should take it for 3.5, I might
get convinced.

I'll follow up with more detailed feedback on the individual patches.

	Arnd
