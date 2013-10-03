From: ijc@hellion.org.uk (Ian Campbell)
Date: Thu, 03 Oct 2013 20:43:23 +0100
Subject: Detect presence of LPAE when not running an LPAE kernel?
Message-ID: <1380829403.3804.56.camel@hastur.hellion.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Is this possible?

The Features field of /proc/cpuinfo only appears to reflect the presence
of LPAE if CONFIG_LPAE is actually on in the running kernel.

The reason I care is so that distro installers can ship a generic kernel
but select LPAE for the running system when appropriate.

On x86 for example I would check /proc/cpuinfo:flags which contains the
CPU features, regardless of whether they are currently enabled.

Is there any equivalent on ARM?

Ian.
