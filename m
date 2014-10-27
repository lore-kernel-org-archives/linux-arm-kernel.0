From: santosh.shilimkar@gmail.com (Santosh Shilimkar)
Date: Mon, 27 Oct 2014 09:34:25 -0700
Subject: [PATCH 1/3] soc: ti: Use list_first_entry_or_null() at appropriate
 places
In-Reply-To: <1414316264.4290.2.camel@phoenix>
References: <1414316264.4290.2.camel@phoenix>
Message-ID: <544E7411.5070208@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Alex,

On 10/26/2014 02:37 AM, Axel Lin wrote:
> Use list_first_entry_or_null() for first_region() and first_queue_range().
>
> list_first_entry() expects the list is not empty, so first_region() and
> first_queue_range() never return NULL.
> Thus use list_first_entry_or_null() instead.
>
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> ---

Thanks. I will pick the $subject and other two patches and queue
them up for next merge window.

Regards,
Santosh
