From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 24 Jan 2014 11:40:13 -0200
Subject: Warning at __kmem_cache_create
In-Reply-To: <20140124131156.GE15937@n2100.arm.linux.org.uk>
References: <CAOMZO5Cbws-Kj-q63iCAFFOyR7gm24Z+VUZTAdzeOgud3B4cjQ@mail.gmail.com>
 <20140124131156.GE15937@n2100.arm.linux.org.uk>
Message-ID: <CAOMZO5AaaYkU_poznEJZN1fmiGav6tAVBww3+dXL8D9esf0mpw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 24, 2014 at 11:11 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:

> So it's some slub change which has yet to hit mainline... I can't say
> much more than that at the moment.

Yes, I found the commit that causes the warning.

Will start a new thread at linux-kernel at vger.kernel.org to discuss it.

Regards,

Fabio Estevam
