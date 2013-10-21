From: robt201108@gmail.com (robert)
Date: Mon, 21 Oct 2013 13:11:08 +0100
Subject: DreamPlug / GuruPlug support in 3.12-rc
In-Reply-To: <20131020215017.GD15169@titan.lakedaemon.net>
References: <5263C7C2.4000204@gmail.com>
 <20131020161747.GA15169@titan.lakedaemon.net> <5264382E.9050207@gmail.com>
 <20131020215017.GD15169@titan.lakedaemon.net>
Message-ID: <526519DC.5030500@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jason,

Apologies for my ignorant 'top-posting'..

My error in logic was to base my testing on a kernel config which seemed
- to me - to 'work', but was actually _incorrect_, as you pointed out.

I decided to scrub the existing config, and start over, from # make
kirkwood_defconfig, and then select/deselect options for the
DreamPlug.    After a bit of trial and error, I now have a working
3.12-rc6 system:

# uname -a
Linux rgdreamplug 3.12.0-rc6 #1 PREEMPT Mon Oct 21 12:54:19 BST 2013
armv5tel armv5tel armv5tel GNU/Linux

Many thanks for your help.

Robert.
