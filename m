From: santosh.shilimkar@oracle.com (santosh.shilimkar@oralce.com)
Date: Mon, 03 Nov 2014 10:27:16 -0800
Subject: [PATCH] soc: ti: knav_qmss_queue: Use list_for_each_entry_safe
 to prevent use after free
In-Reply-To: <1414819993.23500.1.camel@phoenix>
References: <1414819993.23500.1.camel@phoenix>
Message-ID: <5457C904.8070203@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/31/2014 10:33 PM, Axel Lin wrote:
> list_for_each_entry_safe() is necessary if list objects are deleted from
> the list while traversing it.
>
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> ---

Right. Picked up for 3.19. Thanks !!

Regards,
Santosh
