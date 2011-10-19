From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 19 Oct 2011 12:51:44 +0200
Subject: [PATCH 0/3] ARM 4Kstacks: introduction
In-Reply-To: <4E9E1944.80601@am.sony.com>
References: <4E9E0B71.9020708@am.sony.com> <1318983248.7569.5.camel@Joe-Laptop>
	<4E9E1944.80601@am.sony.com>
Message-ID: <1500345.YeXPhIIHc5@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 18 October 2011 17:26:44 Tim Bird wrote:
> Even inside Sony, usage of 4K stacks is limited
> to some very special cases, where memory is exceedingly
> tight (we have one system with 4M of RAM).  And we
> don't mind lopping off features or coding around
> problem areas to support our special case.

I would imagine that in those cases, you can gain more by reducing the
number of threads in the system. What is the highest number of
concurrent threads that you expect in a limited use case with no
networking or block devices?

	Arnd
