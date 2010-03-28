From: nico@fluxnic.net (Nicolas Pitre)
Date: Sun, 28 Mar 2010 19:34:03 -0400 (EDT)
Subject: Query about Float Point Operation
In-Reply-To: <tencent_294E932A6E12E0191CF4271B@qq.com>
References: <tencent_294E932A6E12E0191CF4271B@qq.com>
Message-ID: <alpine.LFD.2.00.1003281933120.694@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 23 Mar 2010, ??? wrote:

> WOW
> My audio codec drivers use float point operation heavily!
> Does that mean that I can ONLY implement it on USER space ?

Yes.  Software codecs don't belong in the kernel anyway.


Nicolas
