From: iamjoonsoo.kim@lge.com (Joonsoo Kim)
Date: Thu, 12 Jun 2014 16:43:29 +0900
Subject: [PATCH v2 09/10] mm, cma: move output param to the end of param
 list
In-Reply-To: <20140612071930.GL12415@bbox>
References: <1402543307-29800-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1402543307-29800-10-git-send-email-iamjoonsoo.kim@lge.com>
 <20140612071930.GL12415@bbox>
Message-ID: <20140612074329.GC20199@js1304-P5Q-DELUXE>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 12, 2014 at 04:19:31PM +0900, Minchan Kim wrote:
> On Thu, Jun 12, 2014 at 12:21:46PM +0900, Joonsoo Kim wrote:
> > Conventionally, we put output param to the end of param list.
> > cma_declare_contiguous() doesn't look like that, so change it.
> 
> If you says "Conventionally", I'd like to suggest one more thing.
> Conventionally, we put 'base' ahead 'size' but dma_contiguous_reserve_area
> is opposite.

Okay. I will do it. :)

Thanks.
