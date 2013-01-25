From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Fri, 25 Jan 2013 16:03:29 +0100
Subject: [RFC V2 PATCH 0/8] ARM: kirkwood: cleanup DT conversion
In-Reply-To: <20130125125214.GI1758@titan.lakedaemon.net>
References: <cover.1358983578.git.jason@lakedaemon.net>
 <cover.1359091286.git.jason@lakedaemon.net>
 <201301251115.47480.arnd@arndb.de>
 <20130125125214.GI1758@titan.lakedaemon.net>
Message-ID: <CABJ1b_QaTBLgGASTs2yi435jR=LepN-iY97xTLXAu1hZw69Wuw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 25, 2013 at 1:52 PM, Jason Cooper <jason@lakedaemon.net> wrote:
> Once I have the mv643xx_eth binding working reliably, preferably with
> mvmdio, I'll take a look at removing the last board-*.c files.  If the
> stars align, we'll get it all done for v3.9.
>
> The only big thing left will be pcie.

Jason,

there is also addr_map that we haven't thought about yet. Is it supposed
to be configurable through DT or do we leave it as "linux wants it that way"?

Sebastian
