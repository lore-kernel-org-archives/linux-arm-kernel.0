From: fujita.tomonori@lab.ntt.co.jp (FUJITA Tomonori)
Date: Fri, 20 Aug 2010 00:15:12 +0900
Subject: [PATCH/RFCv3 0/6] The Contiguous Memory Allocator framework
In-Reply-To: <AANLkTikp49oOny-vrtRTsJvA3Sps08=w7__JjdA3FE8t@mail.gmail.com>
References: <cover.1281100495.git.m.nazarewicz@samsung.com>
	<AANLkTikp49oOny-vrtRTsJvA3Sps08=w7__JjdA3FE8t@mail.gmail.com>
Message-ID: <20100820001339N.fujita.tomonori@lab.ntt.co.jp>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 18 Aug 2010 12:01:35 +0900
Kyungmin Park <kyungmin.park@samsung.com> wrote:

> Are there any comments or ack?
> 
> We hope this method included at mainline kernel if possible.
> It's really needed feature for our multimedia frameworks.

You got any comments from mm people?

Virtually, this adds a new memory allocator implementation that steals
some memory from memory allocator during boot process. Its API looks
completely different from the API for memory allocator. That doesn't
sound appealing to me much. This stuff couldn't be integrated well
into memory allocator?
