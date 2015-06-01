From: jiang.liu@linux.intel.com (Jiang Liu)
Date: Mon, 01 Jun 2015 21:48:53 +0800
Subject: [RFC v1 05/25] gpio: Use irq_desc_get_xxx() to avoid redundant
 lookup of irq_desc
In-Reply-To: <CACRpkdZfWK5H+gRD6inX31Ouq1XCvq7CneNDJV8x0iihXHzWjw@mail.gmail.com>
References: <1432116013-25902-1-git-send-email-jiang.liu@linux.intel.com>	<1432116013-25902-6-git-send-email-jiang.liu@linux.intel.com>
 <CACRpkdZfWK5H+gRD6inX31Ouq1XCvq7CneNDJV8x0iihXHzWjw@mail.gmail.com>
Message-ID: <556C62C5.2040107@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015/6/1 20:45, Linus Walleij wrote:
> On Wed, May 20, 2015 at 11:59 AM, Jiang Liu <jiang.liu@linux.intel.com> wrote:
> 
>> Use irq_desc_get_xxx() to avoid redundant lookup of irq_desc while we
>> already have a pointer to corresponding irq_desc.
>>
>> Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
> 
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> 
> Are there dependencies on this patch or can I just apply it
> directly to the GPIO tree?
Hi Linus,
	Thanks for review.
	There's a very long dependency list of this patch set,
so it would be safer to merge this patch set altogether through
the irq tree if that works:)
Thanks!
Gerry

> 
> Yours,
> Linus Walleij
> 
