From: lokeshvutla@ti.com (Lokesh Vutla)
Date: Wed, 13 Dec 2017 13:29:48 +0530
Subject: [PATCH] firmware: ti_sci: Use %zu for size_t print format
In-Reply-To: <20171202102012.354-1-nm@ti.com>
References: <20171202102012.354-1-nm@ti.com>
Message-ID: <1e370b33-a321-b5f8-450e-cbf8cc0e2426@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Saturday 02 December 2017 03:50 PM, Nishanth Menon wrote:
> mbox_msg->len is of type size_t and %d is incorrect format. Instead
> use %zu for handling size_t correctly.
> 
> Signed-off-by: Nishanth Menon <nm@ti.com>

Reviewed-by: Lokesh Vutla <lokeshvutla@ti.com>

Thanks and regards,
Lokesh
