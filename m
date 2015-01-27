From: paul@pwsan.com (Paul Walmsley)
Date: Tue, 27 Jan 2015 21:31:30 +0000 (UTC)
Subject: arm64: USB_ARCH_HAS_EHCI
In-Reply-To: <1422351833.14015.20.camel@x220>
References: <1422351833.14015.20.camel@x220>
Message-ID: <alpine.DEB.2.02.1501272130470.19947@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 27 Jan 2015, Paul Bolle wrote:

> Your commit d035fdfa27ac ("arm64: Add Tegra132 support") is included in
> today's linux-next (ie, next-20150127). I noticed because a script I use
> to check linux-next spotted a minor problem with it.
> 
> It adds a select for the Kconfig symbol USB_ARCH_HAS_EHCI. That Kconfig
> was obsoleted in v3.11 and removed in v3.15. See commit b797b76fb464
> ("usb: host: remove USB_ARCH_HAS_?HCI"). That select is now a nop.
> 
> Should I submit the trivial patch to remove that line or do you prefer
> to do that yourself?

Thanks, I'll post a new version.


- Paul
