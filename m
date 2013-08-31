From: andi@firstfloor.org (Andi Kleen)
Date: Sat, 31 Aug 2013 16:31:23 +0200
Subject: [PATCH] checkpatch:  Add test for positional misuse of section
 specifiers like __initdata
In-Reply-To: <1377655732.3619.19.camel@joe-AO722>
References: <1377655732.3619.19.camel@joe-AO722>
Message-ID: <20130831143123.GC19750@two.firstfloor.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> A similar patch was suggested by Andi Kleen
> https://lkml.org/lkml/2013/8/5/648

My patch checked for const <-> initdata / non const initconst  mistakes.

I don't think your patch does that?

-Andi
