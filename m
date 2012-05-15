From: nico@fluxnic.net (Nicolas Pitre)
Date: Tue, 15 May 2012 14:42:30 -0400 (EDT)
Subject: [PATCH 1/8] arm: mach-armada: add headers
In-Reply-To: <1337072084-21967-2-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1337072084-21967-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1337072084-21967-2-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <alpine.LFD.2.02.1205151440241.1640@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 15 May 2012, Thomas Petazzoni wrote:

> From: Gregory CLEMENT <gregory.clement@free-electrons.com>
> 
> This patch adds basic header files for Armada SoCs.

Some of those files, such as system.h, have been made obsolete in 
mainline lately.  Please remove them.


Nicolas
