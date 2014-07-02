From: boris.brezillon@free-electrons.com (Boris BREZILLON)
Date: Wed, 2 Jul 2014 18:55:28 +0200
Subject: [PATCH 03/33] clk: at91: main: warn when the main crystal
 frequency is not set
In-Reply-To: <20140702163842.7440.73162@quantum>
References: <1404223962-30471-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1404223962-30471-4-git-send-email-alexandre.belloni@free-electrons.com>
 <20140702101811.2f2a507e@bbrezillon>
 <20140702163842.7440.73162@quantum>
Message-ID: <20140702185528.5699843a@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 02 Jul 2014 09:38:42 -0700
Mike Turquette <mturquette@linaro.org> wrote:

> Quoting Boris BREZILLON (2014-07-02 01:18:11)
> > On Tue,  1 Jul 2014 16:12:12 +0200
> > Alexandre Belloni <alexandre.belloni@free-electrons.com> wrote:
> > 
> > > When the main crystal frequency is not set, the main clock is
> > > approximated using the MAINF value in the CKGR_MCFR register. Warn
> > > the user in that case.
> > > 
> > > Signed-off-by: Alexandre Belloni
> > > <alexandre.belloni@free-electrons.com> ---
> > 
> > Acked-by: Boris BREZILLON <boris.brezillon@overkiz.com>
> > 
> > Mike, do you want me to take this patch and send you a pull request, or
> > should I let you take this one directly ?
> 
> I've picked it up since it is just the one patch.
> 

Thanks.

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
