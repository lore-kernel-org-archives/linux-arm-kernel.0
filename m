From: michael@walle.cc (Michael Walle)
Date: Wed, 15 Jun 2011 00:01:08 +0200
Subject: [PATCH 0/2 RFC] arm/kirkwood: add dreamplug support.
In-Reply-To: <cover.1308080024.git.jason@lakedaemon.net>
References: <cover.1308080024.git.jason@lakedaemon.net>
Message-ID: <201106150001.08606.michael@walle.cc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag 14 Juni 2011, 21:52:53 schrieb linux_arm at lakedaemon.net:
> From: Jason Cooper <linux_arm@lakedaemon.net>
> This is an RFC patch series until mach-types is updated.  This compiles,
> loads, runs, and sees the SPI flash.

Hi Jason,

in case no one else reply to your patch. I wanted to submit a patch, which 
adds support for the LS-XHL, based on kirkwood, too. Old-fashioned machine 
support files won't be accepted anymore. Instead you would have to submit a 
DTS once the kirkwood arch has support for device trees.

-- 
Michael
