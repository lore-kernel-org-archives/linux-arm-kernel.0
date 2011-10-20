From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 20 Oct 2011 15:10:43 +0200
Subject: [GIT PULL] Calxeda Highbank platform support
In-Reply-To: <4E97A630.3070603@gmail.com>
References: <4E97A630.3070603@gmail.com>
Message-ID: <201110201510.43204.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 14 October 2011, Rob Herring wrote:
> Please pull initial support for Calxeda highbank platform. This is based
> on my GIC DT binding pull request.
> 
> As it appears vmalloc.h and memory.h clean-ups won't make it for 3.2,
> this includes those headers. I'll post follow-ups to delete them if they
> do in fact go in.

Ok, sounds good

> The following changes since commit 8322153302d9bb3fdceda9e0df00d3c69d1964bd:
> 
>   ARM: gic: add OF based initialization (2011-10-13 20:40:29 -0500)
> 
> are available in the git repository at:
> 
>   http://sources.calxeda.com/git/kernel/linux.git hb_for_3.2

I've pulled them into the next/soc branch.

	Arnd
