From: andi@firstfloor.org (Andi Kleen)
Date: Thu, 16 Aug 2012 18:20:52 +0200
Subject: [GIT PULL] Update LZO compression
In-Reply-To: <502D100D.2030609@pobox.com>
References: <50299142.2030504@oberhumer.com>
 <20120814123937.GA14756@sig21.net> <502B8FE3.7080501@oberhumer.com>
 <20120815144539.GA8300@sig21.net> <502C92C3.7090701@oberhumer.com>
 <502D100D.2030609@pobox.com>
Message-ID: <20120816162051.GK11413@one.firstfloor.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> If you think a little bit, I bet you could come up with a solution that 
> operates at cacheline-aligned granularity, something that would be _even 
> faster_ than simply fixing the code to do aligned accesses.

Cache aligned compression is unlikely to compress anything at all.
Compression algorithms are usually by definition unaligned.

-Andi
