From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 27 Apr 2012 22:41:28 +0100
Subject: [PATCH 2/8] dmaengine: amba-pl08x: ensure physical channels
 are properly held
In-Reply-To: <CACRpkdY8rJYQhUwtW1mtmnY8WB7T7mowefqOmiJdCZ1iS5E89A@mail.gmail.com>
References: <20120418100954.GK25053@n2100.arm.linux.org.uk>
 <E1SKRqh-0004b8-RH@rmk-PC.arm.linux.org.uk>
 <20120418101938.GM25053@n2100.arm.linux.org.uk>
 <CACRpkdY8rJYQhUwtW1mtmnY8WB7T7mowefqOmiJdCZ1iS5E89A@mail.gmail.com>
Message-ID: <20120427214128.GH28062@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 27, 2012 at 10:38:08PM +0200, Linus Walleij wrote:
> On Wed, Apr 18, 2012 at 12:19 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> 
> > Oops, this patch wasn't supposed to be part of this set...
> 
> ...however it gives me the impression that you have a patch set cooking
> to also switch PL08x over to the virtual channel mechanism which is
> really appetizing to see :-)

Actually, that doesn't exist yet.

This was a patch I'd had floating around, but I don't think its needed
in any way - I mis-analysed the code and created the patch...
