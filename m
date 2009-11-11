From: tbm@cyrius.com (Martin Michlmayr)
Date: Wed, 11 Nov 2009 17:20:35 +0000
Subject: Status of bzip2 and lzma kernel compression for ARM?
In-Reply-To: <20091111170729.GG2605@pc-ran3241.res.insa>
References: <20091111163404.GA4362@deprecation.cyrius.com>
	<20091111170729.GG2605@pc-ran3241.res.insa>
Message-ID: <20091111172035.GA9682@deprecation.cyrius.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Albin Tonnerre <albin.tonnerre@free-electrons.com> [2009-11-11 18:07]:
> Regarding Bzip2, some testing showed that the decompressor needs at least 3.5Mb
> of memory available for malloc(), which is not available on ARM as head.S
> allocates only 64kb, so I'm sure what to do about it. At this stage, I think
> the most sensible thing to do is forgetting about using bzip2 on ARM.

I'm mostly interested in LZMA, so lack of bzip2 support would not be a
problem for me.

> The LZMA patch relies on patch 2/4 of the LZO patchset, which I
> resubmitted today: http://lkml.org/lkml/2009/11/11/129  I'll likely
> submit the LZMA patch once I get Russell's approval on the ARM part
> of the LZO patchset. In the

Excellent!  I'll give your patch a go on the weekend.
-- 
Martin Michlmayr
http://www.cyrius.com/
