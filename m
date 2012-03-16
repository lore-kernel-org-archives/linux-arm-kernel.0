From: davem@davemloft.net (David Miller)
Date: Fri, 16 Mar 2012 13:54:03 -0700 (PDT)
Subject: [PATCH v8] ARM: net: JIT compiler for packet filters
In-Reply-To: <4F63A106.9060603@gmail.com>
References: <4F639787.7070801@gmail.com>
 <1331929062.19406.21.camel@edumazet-glaptop>
 <4F63A106.9060603@gmail.com>
Message-ID: <20120316.135403.1245702993058109595.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mircea Gherzan <mgherzan@gmail.com>
Date: Fri, 16 Mar 2012 21:22:30 +0100

> Am 16.03.2012 21:17, schrieb Eric Dumazet:
>> On Fri, 2012-03-16 at 20:41 +0100, Mircea Gherzan wrote:
>> 
>>> Updated in the patch tracking system as 7259/3. Hopefully it's not too
>>> late for the inclusion in 3.4.
>> 
>> What was the point of copy/pasting the whole mail ?
> 
> I forgot to cc netdev in the first mail. Sorry.

That doesn't work, if you just quote the patch then it doesn't
get picked up by patchwork at all.

You have to make a real, fresh, patch postings for it to get
logged correctly.
