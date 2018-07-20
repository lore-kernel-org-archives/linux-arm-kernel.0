From: jmkrzyszt@gmail.com (Janusz Krzysztofik)
Date: Fri, 20 Jul 2018 20:14:55 +0200
Subject: [RFC PATCH 4/8] mtd: rawnand: ams-delta: Optimize pointer
 resolution on read/write
In-Reply-To: <20180719082538.222396bf@bbrezillon>
References: <20180718235710.18242-1-jmkrzyszt@gmail.com>
 <20180718235710.18242-5-jmkrzyszt@gmail.com>
 <20180719082538.222396bf@bbrezillon>
Message-ID: <9888773.rgnYII6m0f@z50>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, July 19, 2018 8:25:38 AM CEST Boris Brezillon wrote:
> On Thu, 19 Jul 2018 01:57:06 +0200
> Janusz Krzysztofik <jmkrzyszt@gmail.com> wrote:
> 
> > Further optimize processing speed of read/write callback functions by
> > resolving private structure pointer only once per callback and passing
> > it to all subfunctions instead of mtd_info.

OK, I'll call it simplification (the code looks more simple after that, doesn't 
it), not optimization if you agree.

Thanks,
Janusz
