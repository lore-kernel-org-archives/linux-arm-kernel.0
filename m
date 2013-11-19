From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 19 Nov 2013 11:40:36 -0700
Subject: [RFC PATCH V2 2/2] kbuild: dtbs_install: new make target
In-Reply-To: <20131119142336.GA28859@titan.lakedaemon.net>
References: <cover.1384798508.git.jason@lakedaemon.net>
 <eaf050fbd62803784856a4f37d4b332f7778e22c.1384798508.git.jason@lakedaemon.net>
 <528A65DF.8060000@wwwdotorg.org>
 <20131118191955.GG10335@titan.lakedaemon.net>
 <528A6944.3070303@wwwdotorg.org>
 <20131118192852.GI10335@titan.lakedaemon.net>
 <528A6CA3.9030904@wwwdotorg.org>
 <20131118195243.GJ10335@titan.lakedaemon.net>
 <528A98C8.9040803@wwwdotorg.org>
 <20131119122801.GL16735@n2100.arm.linux.org.uk>
 <20131119142336.GA28859@titan.lakedaemon.net>
Message-ID: <528BB0A4.9030501@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/19/2013 07:23 AM, Jason Cooper wrote:
...
> That's why I prefer to rename the dtbs, it removes the need to parse the
> dtb (fdtget *isn't* currently built/installed by default in dtc)

fdtget is in fact both built and installed by default. At the very least
in the latest dtc source, and it's certainly part of at least the Ubuntu
packages for older versions too, so I assume it's been the default for a
while.
