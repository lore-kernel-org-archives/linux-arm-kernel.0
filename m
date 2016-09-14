From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 14 Sep 2016 14:34:59 +0200
Subject: [PATCH V2 2/4] ARM64 LPC: LPC driver implementation on Hip06
In-Reply-To: <57D79D31.8090607@gmail.com>
References: <1473255233-154297-1-git-send-email-yuanzhichang@hisilicon.com>
 <74367472.RYBpLsaIy1@wuerfel> <57D79D31.8090607@gmail.com>
Message-ID: <2177841.jeJr0YpaiD@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, September 13, 2016 2:31:13 PM CEST zhichang wrote:
> > 
> > What are the other LPC cycle types that could be supported?
> O. memory and firmware operations are supported too. But at this moment, we only use IO cycle.

What are firmware operations?

Are the memory operations directly mapped or do you also have to go through
an indirect function call?

	Arnd
