From: kaloz@openwrt.org (Imre Kaloz)
Date: Wed, 07 Mar 2012 18:09:07 +0100
Subject: [PATCH] ARM: remove ixp2000 platform
In-Reply-To: <201203061412.00073.arnd@arndb.de>
References: <1330450426-14639-1-git-send-email-robherring2@gmail.com>
 <201202281945.39419.arnd@arndb.de>
 <alpine.LFD.2.02.1203052035170.31242@xanadu.home>
 <201203061412.00073.arnd@arndb.de>
Message-ID: <op.was8lhu82s3iss@ecaz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 06 Mar 2012 15:11:59 +0100, Arnd Bergmann <arnd@arndb.de> wrote:

<snip>

>
> Interestingly, that leaves ixp4xx as the only big-endian ARM platform.
> I believe that ixp4xx is still being actively used quite a bit, but does
> that include the big-endian ones? There is no immediate reason why we
> would want to drop support for big-endian, but if it's not used at all,
> that would be an interesting cleanup opportunity.

IXP4xx is almost exclusively used in BE mode.


Imre
