From: sboyd@kernel.org (Stephen Boyd)
Date: Wed, 07 Nov 2018 16:18:35 -0800
Subject: [PATCH v9 3/5] clk: imx: add SCCG PLL type
In-Reply-To: <20181107202624.oya2runvbbwcilzu@fsr-ub1664-175>
References: <1537785597-26499-1-git-send-email-abel.vesa@nxp.com>
 <1537785597-26499-4-git-send-email-abel.vesa@nxp.com>
 <153980615257.5275.13866740376184829057@swboyd.mtv.corp.google.com>
 <20181107115444.gscxwud7e57nx3c7@fsr-ub1664-175>
 <154161726247.88331.15629902810537417880@swboyd.mtv.corp.google.com>
 <20181107202624.oya2runvbbwcilzu@fsr-ub1664-175>
Message-ID: <154163631513.88331.1765456171211364913@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Abel Vesa (2018-11-07 12:26:25)
> On Wed, Nov 07, 2018 at 11:01:02AM -0800, Stephen Boyd wrote:
> > 
> > 
> > What's the plan to clean it up?
> 
> So I'm doing this in our internal tree first to make sure I don't break the
> other (newer) socs.
> 
> I already have a prototype in testing but it's a long way to upstream it.
> 
> Basically, I'm replacing all of this with a single, more like a composite,
> more complex, clock type that does all the magic inside.
> 
> One of the problems is the fact that the bypasses can have the same sources
> and in my case, I'm implementing that as a list of parents name, but the
> parent names list doesn't work with duplicates, so I have to find some other
> way to do it.
> 
> Once I have something clean and tested enough I'll send it upstream.

Ok. Thanks for the info.
