From: mturquette@ti.com (Turquette, Mike)
Date: Mon, 9 Apr 2012 16:04:16 -0700
Subject: COMMON_CLK_DISABLE_UNUSED
In-Reply-To: <20120409222903.GA31622@lunn.ch>
References: <20120409222903.GA31622@lunn.ch>
Message-ID: <CAJOA=zP8XFTN1mcAyUky3ovrx4Dg1zb9zaB5r8zUYE46Ec-tMQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 9, 2012 at 3:29 PM, Andrew Lunn <andrew@lunn.ch> wrote:
> I think it would be good to consider deleting this config option and
> just have the code always enabled.

I agree.  We already support the CLK_IGNORE_UNUSED flag, so any
platforms that don't want this functionality wholesale can set that
bit for every clock.

I'll pull out that option.

Regards,
Mike
