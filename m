From: mturquette@linaro.org (Mike Turquette)
Date: Thu, 30 Jan 2014 13:47:15 -0800
Subject: linux-next: manual merge of the arm-soc tree with Linus' tree
In-Reply-To: <CAGa+x85md++qtw5n7c_4L-MvaK8nB3c8GpFf+OLb4p--8N=+og@mail.gmail.com>
References: <20140130111919.afc7f4e5b58e409aaabf7550@canb.auug.org.au>
 <CAGa+x85md++qtw5n7c_4L-MvaK8nB3c8GpFf+OLb4p--8N=+og@mail.gmail.com>
Message-ID: <CAPtuhTgAF7u-yZi3OpmAPikhp25nu+ooqEQXbJELVKTkAaJh4A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 29, 2014 at 9:33 PM, Kevin Hilman <khilman@linaro.org> wrote:
> On Wed, Jan 29, 2014 at 4:19 PM, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>> Hi all,
>>
>> Today's linux-next merge of the arm-soc tree got a conflict in
>> drivers/clk/Makefile between commit fd3fdaf09f26 ("clk: sort Makefile")
>> from Linus' tree and commit 7ee2c5117483 ("clk: bcm281xx: add initial
>> clock framework support") from the arm-soc tree.
>
> Ugh.  Looks like some last minute cleanup stuff went into clk-next
> that didn't spend time in linux-next, and now causes conflicts with
> some clk stuff we still have queued in arm-soc (ack'd by Mike.)
>
> Now, based on the Hulk's response to Mike's pull request, if we submit
> this, introducing yet more conflicts in the Makefile, it will surely
> be Hulk angry, Hulk smash.

Well this is clearly my fault. Please place appropriate blame on me
for sneaking in that Makefile cleanup.

/me prepares to be smashed.

Regards,
Mike

>
> Kevin
