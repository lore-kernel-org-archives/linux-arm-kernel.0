From: jonas.jensen@gmail.com (Jonas Jensen)
Date: Mon, 18 Mar 2013 11:22:38 +0100
Subject: [PATCH 3/6] ARM: remove fa526 CPU support
In-Reply-To: <514318DE.8060601@openwrt.org>
References: <1363299178-8241-1-git-send-email-arnd@arndb.de>
 <1363299178-8241-4-git-send-email-arnd@arndb.de>
 <514318DE.8060601@openwrt.org>
Message-ID: <CACmBeS2tbV9Z_c3mCuk4G_+kYpVpVpUKWq3GK=gqBF+ECNhTbg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15 March 2013 13:49, Florian Fainelli <florian@openwrt.org> wrote:
> Someone recently announced support for a Moxart SoC which seems to use the
> FA526 core however.

That was probably me, and I understand people want it gone. Even
Debian wants v4:s gone because they're not strictly EABI (
http://lists.debian.org/debian-arm/2010/12/msg00044.html ).

The port is not near mainline but I think I'd prefer if CPU_FA526
wasn't removed. If someone stepped up to maintain ARCH_GEMINI (so I
could peek at the changes) that would be even better :)

Best regards,
Jonas
