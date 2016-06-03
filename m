From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 3 Jun 2016 17:44:30 +0200
Subject: [PATCH v2 1/3] of: add common OF-based component functionality
In-Reply-To: <E1b8pyR-0005OJ-V3@rmk-PC.armlinux.org.uk>
References: <20160603141548.GC1041@n2100.armlinux.org.uk>
 <E1b8pyR-0005OJ-V3@rmk-PC.armlinux.org.uk>
Message-ID: <20160603154430.GA21013@ulmo.ba.sec>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 03, 2016 at 03:21:19PM +0100, Russell King wrote:
[...]
> diff --git a/drivers/of/of_component.c b/drivers/of/of_component.c
[...]
> +static void component_compare_of(struct device *dev, void *data)
> +{
> +	return dev->of_node == data;
> +}

The return statement here doesn't match the return value. Didn't GCC
complain about this?

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160603/196b25a6/attachment.sig>
