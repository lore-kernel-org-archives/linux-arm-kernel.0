From: j.anaszewski@samsung.com (Jacek Anaszewski)
Date: Mon, 26 Oct 2015 09:48:31 +0100
Subject: [PATCH 0/9] add missing of_node_put
In-Reply-To: <1445697755-26341-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1445697755-26341-1-git-send-email-Julia.Lawall@lip6.fr>
Message-ID: <562DE8DF.5090609@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Julia,

Patches 1-4 have been applied to the LED tree, thanks.

On 10/24/2015 04:42 PM, Julia Lawall wrote:
> The various for_each device_node iterators performs an of_node_get on each
> iteration, so a break out of the loop requires an of_node_put.
>
> The complete semantic patch that fixes this problem is
> (http://coccinelle.lip6.fr):
>
[...]

-- 
Best Regards,
Jacek Anaszewski
