From: pebolle@tiscali.nl (Paul Bolle)
Date: Tue, 27 Jan 2015 10:43:53 +0100
Subject: arm64: USB_ARCH_HAS_EHCI
Message-ID: <1422351833.14015.20.camel@x220>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Paul,

Your commit d035fdfa27ac ("arm64: Add Tegra132 support") is included in
today's linux-next (ie, next-20150127). I noticed because a script I use
to check linux-next spotted a minor problem with it.

It adds a select for the Kconfig symbol USB_ARCH_HAS_EHCI. That Kconfig
was obsoleted in v3.11 and removed in v3.15. See commit b797b76fb464
("usb: host: remove USB_ARCH_HAS_?HCI"). That select is now a nop.

Should I submit the trivial patch to remove that line or do you prefer
to do that yourself?

Thanks,


Paul Bolle
