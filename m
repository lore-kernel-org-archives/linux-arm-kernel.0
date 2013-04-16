From: mturquette@linaro.org (Mike Turquette)
Date: Mon, 15 Apr 2013 21:45:14 -0700
Subject: [PATCH] clk: si5351: make clk-si5351 depend on CONFIG_OF
In-Reply-To: <20130416105513.913219ac889b1db952876197@canb.auug.org.au>
References: <1366009214-32234-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <20130416105513.913219ac889b1db952876197@canb.auug.org.au>
Message-ID: <20130416044514.19887.93969@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Stephen Rothwell (2013-04-15 17:55:13)
> Hi Sebastian,
> 
> On Mon, 15 Apr 2013 09:00:14 +0200 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com> wrote:
> >
> > Calling clk-si5351 driver non-OF ready was too early. This patch
> > makes clk-si5351 depend on CONFIG_OF again, until things get sorted out.
> > 
> > Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> > Reported-by: Stephen Rottweil <sfr@canb.auug.org.au>
> 
> My name is spelt "Rothwell" (as in the Cc: line below) :-(
> 

It's fixed in the merged version.

Regards,
Mike

> > ---
> > Cc: Stephen Rothwell <sfr@canb.auug.org.au>
> 
> -- 
> Cheers,
> Stephen Rothwell                    sfr at canb.auug.org.au
