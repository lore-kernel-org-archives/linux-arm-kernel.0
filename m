From: dwmw2@infradead.org (David Woodhouse)
Date: Fri, 16 Oct 2009 18:20:31 +0100
Subject: [PATCH 1/2] Update ts72xx to use generic platform nand driver
In-Reply-To: <BD79186B4FD85F4B8E60E381CAEE190901E244EA@mi8nycmail19.Mi8.com>
References: <BD79186B4FD85F4B8E60E381CAEE190901DB7967@mi8nycmail19.Mi8.com>
	<1255260621.16942.38.camel@localhost>
	<BD79186B4FD85F4B8E60E381CAEE190901DB7E59@mi8nycmail19.Mi8.com>
	<1255509739.32489.123.camel@localhost>
	<BD79186B4FD85F4B8E60E381CAEE190901DB8132@mi8nycmail19.Mi8.com>
	<1255675123.32489.310.camel@localhost>
	<BD79186B4FD85F4B8E60E381CAEE190901E244EA@mi8nycmail19.Mi8.com>
Message-ID: <1255713631.18879.675.camel@macbook.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2009-10-16 at 13:09 -0400, H Hartley Sweeten wrote:
> +               pr_warning("ts72xx: Unknown nand disk size:%lluMB\n", size >> 20);

If it's >>20, then you mean 'MiB' not 'MB'.

-- 
dwmw2
