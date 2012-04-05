From: grant.likely@secretlab.ca (Grant Likely)
Date: Thu, 5 Apr 2012 16:19:34 -0700
Subject: CONFIG_EARLY_PRINTK on versatile broken in mainline
In-Reply-To: <CAOMZO5DFmqz0Rp9oFR7tyofQ9iAfNWXTEYOFVcYvxWPcf6DDMQ@mail.gmail.com>
References: <CACxGe6twdkkQaN+ieZoFpjvQAect7-6mUz+N8yULDzwtwHoW1Q@mail.gmail.com>
 <CAOMZO5DFmqz0Rp9oFR7tyofQ9iAfNWXTEYOFVcYvxWPcf6DDMQ@mail.gmail.com>
Message-ID: <CACxGe6sQ9YR-i4BJOsB0uE7U7gP7Y4Q12rjiEhqQnJGX+FEgfw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 5, 2012 at 4:08 PM, Fabio Estevam <festevam@gmail.com> wrote:
> On Thu, Apr 5, 2012 at 7:52 PM, Grant Likely <grant.likely@secretlab.ca> wrote:
>> Has anyone else had problems with CONFIG_EARLY_PRINTK on current
>> mainline? ?ARM versatile fails to boot on qemu when it is selected.
>> I've just started bisecting. ?v3.3 is okay, but current mainline is
>> broken. ?Output stops after dumping out the memblock regions, and
>> __log_buf stops at the same place.
>
> Please try this patch:
> http://permalink.gmane.org/gmane.linux.ports.arm.kernel/158694

I've already had that fix applied.  This is a different issue.  The
kernel boots fine if CONFIG_EARLY_PRINTK isn't defined.

g.


-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
