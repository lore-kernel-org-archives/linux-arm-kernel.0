From: santosh.shilimkar@oracle.com (santosh.shilimkar at oracle.com)
Date: Sat, 16 Dec 2017 14:43:16 -0800
Subject: [PATCH] firmware: ti_sci: Use %zu for size_t print format
In-Reply-To: <20171202102012.354-1-nm@ti.com>
References: <20171202102012.354-1-nm@ti.com>
Message-ID: <587c987b-8eff-5828-95d2-24daeca75792@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/2/17 2:20 AM, Nishanth Menon wrote:
> mbox_msg->len is of type size_t and %d is incorrect format. Instead
> use %zu for handling size_t correctly.
> 
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
Applied to 'for_4.16/drivers-soc' with Lokesh's ack.
