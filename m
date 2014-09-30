From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 30 Sep 2014 15:26:06 +0200
Subject: [PATCH] sched, time: cmpxchg does not work on 64-bit variable
In-Reply-To: <542AA33E.2050008@redhat.com>
References: <2547036.UshV4pXvhf@wuerfel> <542AA33E.2050008@redhat.com>
Message-ID: <6045627.KStXj7ELPe@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 30 September 2014 08:34:06 Rik van Riel wrote:
> 
> Arnd, on which architecture are you seeing a build failure?
> Is it just 32 bit arm?
> 

Yes, I only tested on arm32, but I assume that most other 32-bit
architectures will behave in a similar way.

	Arnd
