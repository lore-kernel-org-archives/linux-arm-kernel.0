From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 6 Mar 2012 17:10:53 +0000
Subject: [PATCH] ARM: remove ixp2000 platform
In-Reply-To: <alpine.LFD.2.02.1203061146210.31242@xanadu.home>
References: <1330450426-14639-1-git-send-email-robherring2@gmail.com>
 <201203061412.00073.arnd@arndb.de>
 <alpine.LFD.2.02.1203061146210.31242@xanadu.home>
Message-ID: <201203061710.54171.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 06 March 2012, Nicolas Pitre wrote:
> The NSLU2 is (was) a quite popular NAS device and it is used in big 
> endian by default.
> 
> The BE support isn't getting in the way of anything, so there is no 
> reason to remove it, even if it isn't being used much.

Ok, that's what I thought, just making sure. If it was completely
dead code, things would be different.

	Arnd
