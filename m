From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 5 Apr 2012 20:08:57 -0300
Subject: CONFIG_EARLY_PRINTK on versatile broken in mainline
In-Reply-To: <CACxGe6twdkkQaN+ieZoFpjvQAect7-6mUz+N8yULDzwtwHoW1Q@mail.gmail.com>
References: <CACxGe6twdkkQaN+ieZoFpjvQAect7-6mUz+N8yULDzwtwHoW1Q@mail.gmail.com>
Message-ID: <CAOMZO5DFmqz0Rp9oFR7tyofQ9iAfNWXTEYOFVcYvxWPcf6DDMQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 5, 2012 at 7:52 PM, Grant Likely <grant.likely@secretlab.ca> wrote:
> Has anyone else had problems with CONFIG_EARLY_PRINTK on current
> mainline? ?ARM versatile fails to boot on qemu when it is selected.
> I've just started bisecting. ?v3.3 is okay, but current mainline is
> broken. ?Output stops after dumping out the memblock regions, and
> __log_buf stops at the same place.

Please try this patch:
http://permalink.gmane.org/gmane.linux.ports.arm.kernel/158694
