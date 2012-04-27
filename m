From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 27 Apr 2012 22:38:08 +0200
Subject: [PATCH 2/8] dmaengine: amba-pl08x: ensure physical channels are
 properly held
In-Reply-To: <20120418101938.GM25053@n2100.arm.linux.org.uk>
References: <20120418100954.GK25053@n2100.arm.linux.org.uk>
 <E1SKRqh-0004b8-RH@rmk-PC.arm.linux.org.uk>
 <20120418101938.GM25053@n2100.arm.linux.org.uk>
Message-ID: <CACRpkdY8rJYQhUwtW1mtmnY8WB7T7mowefqOmiJdCZ1iS5E89A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 18, 2012 at 12:19 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:

> Oops, this patch wasn't supposed to be part of this set...

...however it gives me the impression that you have a patch set cooking
to also switch PL08x over to the virtual channel mechanism which is
really appetizing to see :-)

Yours,
Linus Walleij
