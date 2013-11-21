From: grant.likely@secretlab.ca (Grant Likely)
Date: Thu, 21 Nov 2013 07:48:59 +0000
Subject: [PATCH V4] kbuild: dtbs_install: new make target
In-Reply-To: <20131120170845.GJ28859@titan.lakedaemon.net>
References: <1384201760-16785-1-git-send-email-jason@lakedaemon.net> <
 1384896475-8744-1-git-send-email-jason@lakedaemon.net> <528BDEED.8080708@
 wwwdotorg.org> <20131120170845.GJ28859@titan.lakedaemon.net>
Message-ID: <20131121074859.4CF60C4077A@trevor.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 20 Nov 2013 12:08:45 -0500, Jason Cooper <jason@lakedaemon.net> wrote:
> I'm still not in favor of installing to /boot/anything since /boot is
> often a separate, small partition.  I even set mine not to automount.
> The number and size of dtbs is only going to grow.  Better to install
> them in a location with lots of space, and /lib is used to having the
> kernel modules installed in it.

This is just the kernel default action. It can be overridden with a
local script or an environment variable. /boot definitely makes more
sense that /lib.

g.
