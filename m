From: frowand.list@gmail.com (Frank Rowand)
Date: Fri, 28 Sep 2018 12:43:41 -0700
Subject: drivers binding to device node with multiple compatible strings
In-Reply-To: <CADRPPNT0QiBkJtJnxjW95Yf-mirL5OzRrvqj8rC-O8fiz17VnA@mail.gmail.com>
References: <CADRPPNT0QiBkJtJnxjW95Yf-mirL5OzRrvqj8rC-O8fiz17VnA@mail.gmail.com>
Message-ID: <ecbf11cd-a140-fe7e-392a-bccbf8224d14@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


+ Frank

On 09/27/18 15:25, Li Yang wrote:
> Hi Rob and Grant,
> 
> Various device tree specs are recommending to include all the
> potential compatible strings in the device node, with the order from
> most specific to most general.  But it looks like Linux kernel doesn't
> provide a way to bind the device to the most specific driver, however,
> the first registered compatible driver will be bound.
> 
> As more and more generic drivers are added to the Linux kernel, they
> are competing with the more specific vendor drivers and causes problem
> when both are built into the kernel.  I'm wondering if there is a
> generic solution (or in plan) to make the most specific driver bound
> to the device.   Or we have to disable the more general driver or
> remove the more general compatible string from the device tree?
> 
> Regards,
> Leo
> 
