From: khilman@linaro.org (Kevin Hilman)
Date: Wed, 29 Jan 2014 21:33:15 -0800
Subject: linux-next: manual merge of the arm-soc tree with Linus' tree
In-Reply-To: <20140130111919.afc7f4e5b58e409aaabf7550@canb.auug.org.au>
References: <20140130111919.afc7f4e5b58e409aaabf7550@canb.auug.org.au>
Message-ID: <CAGa+x85md++qtw5n7c_4L-MvaK8nB3c8GpFf+OLb4p--8N=+og@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 29, 2014 at 4:19 PM, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> Hi all,
>
> Today's linux-next merge of the arm-soc tree got a conflict in
> drivers/clk/Makefile between commit fd3fdaf09f26 ("clk: sort Makefile")
> from Linus' tree and commit 7ee2c5117483 ("clk: bcm281xx: add initial
> clock framework support") from the arm-soc tree.

Ugh.  Looks like some last minute cleanup stuff went into clk-next
that didn't spend time in linux-next, and now causes conflicts with
some clk stuff we still have queued in arm-soc (ack'd by Mike.)

Now, based on the Hulk's response to Mike's pull request, if we submit
this, introducing yet more conflicts in the Makefile, it will surely
be Hulk angry, Hulk smash.

Kevin
