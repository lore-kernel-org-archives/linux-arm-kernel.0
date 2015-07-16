From: richardcochran@gmail.com (Richard Cochran)
Date: Thu, 16 Jul 2015 19:10:54 +0200
Subject: [PATCH 1/2] gpio: dwapb: Use human understandable gpio numbering.
In-Reply-To: <CACRpkdY+prqSeohT5BEoOKS6sfXdFTA6ZzuKzH4GSPX5jcjgzA@mail.gmail.com>
References: <cover.1435777856.git.rcochran@linutronix.de>
 <d6b5ce85a17164970d454583560e07f7aed7b8ca.1435777856.git.rcochran@linutronix.de>
 <CACRpkdY+prqSeohT5BEoOKS6sfXdFTA6ZzuKzH4GSPX5jcjgzA@mail.gmail.com>
Message-ID: <20150716171054.GA27060@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 16, 2015 at 09:50:44AM +0200, Linus Walleij wrote:
> We are working to remove dependency on them by introducing GPIO
> descriptors and thinking heavily about how to handle the userspace
> sysfs ABI moving forward. But for the ABI the numbers just need to
> be stable, not intuitive.

The numbers are *not* stable.  That is a problem for users like me.

Thanks,
Richard
