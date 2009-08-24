From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Mon, 24 Aug 2009 16:40:10 +0300
Subject: ARM subarch submissions for next merge window
Message-ID: <877hwtnxdx.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Linus,

After some discussions on linux-arm-kernel during the last merge
window, a suggestion from Alan Cox[1], and a willingness to try it
from Russell[2], some ARM subarch maintainers would like to push our
platform-specific code directly to you for the next merge window.

Any changes that affect common ARM code will still be pushed via
Russell, only our platform-specific code will be submitted directly.

Also our platform code is still posted and reviewed on
linux-arm-kernel as well as being included in linux-next. Only the
merge path will change slightly.

Any problems with this?

Kevin
 maintainer: arch/arm/mach-davinci/*
 developer: arch/arm/mach-omap2/*

[1] http://marc.info/?l=linux-arm-kernel&m=124472557106678&w=2
[2] http://marc.info/?l=linux-kernel&m=124472614607233&w=2
