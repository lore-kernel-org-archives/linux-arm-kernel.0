From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 12 Jul 2013 23:26:18 +0100
Subject: Sharing *.dtsi between Linux architectures?
In-Reply-To: <51E05FEB.1090308@wwwdotorg.org>
References: <51E05FEB.1090308@wwwdotorg.org>
Message-ID: <20130712222618.GJ24642@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 12, 2013 at 01:58:35PM -0600, Stephen Warren wrote:
> Is there a (possibly just proposed) mechanism in place to allow *.dts
> from multiple Linux architectures to share common *.dtsi files?

Don't forget that the long term goal is to move these files out of the
kernel source, which means that they'll be a separately managed project,
possibly with a different file structure.
