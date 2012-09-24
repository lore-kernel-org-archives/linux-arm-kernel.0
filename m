From: olof@lixom.net (Olof Johansson)
Date: Sun, 23 Sep 2012 22:37:44 -0700
Subject: [GIT PULL V5 0/7] ARM: kirkwood/dove/mvebu changes for v3.7
In-Reply-To: <20120924052301.GE14266@lunn.ch>
References: <20120922171554.GE5469@titan.lakedaemon.net>
 <20120924052301.GE14266@lunn.ch>
Message-ID: <CAOesGMj6HBMFWr+3RfEmEg8GvRvPU5QguOhyiMD=cUftR5Opmw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sun, Sep 23, 2012 at 10:23 PM, Andrew Lunn <andrew@lunn.ch> wrote:
> Hi Arnd, Olof, Jason.
>
> I tested arm-soc/late/kirkwood on an orion5x board. There is an
> unrelated problem, which i should of really seen earlier....
>
> ERROR: 256 KiB atomic DMA coherent pool is too small!
> Please increase it with coherent_pool= kernel parameter!
>
> We had the same problem with kirkwood. I will submit a patch against
> 3.6-rc7. Is there still time for that? Otherwise it would be good to
> have in 3.7 and cc: stable so 3.6.1 gets the fix.

There's still some time, Linus just tagged -rc7 so we will have
somewhere between a few days and maybe a week until final 3.6.

> When i increase the coherent pool size on the command line, it boots
> O.K. I don't have any PCI devices on this board, but the two root
> controllers are listed by lspci.

Ok, great. It'd of course be good to see if something on the bus shows
up too, if you can.


-Olof
