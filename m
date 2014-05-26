From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Mon, 26 May 2014 13:22:32 +0200
Subject: [RFC PATCH 2/5] clk: Introduce 'clk_round_rate_nearest()'
In-Reply-To: <CAKohpomb+h6ZNDgJ8AwJ_J9DjMB7AP_v-cp8coG3CACo5Wt4vQ@mail.gmail.com>
References: <20140521073457.GD31687@pengutronix.de>
 <00f65d1c-a375-40e7-b30a-cd8cb3ca87fc@BN1BFFO11FD020.protection.gbl>
 <CAKohpomb+h6ZNDgJ8AwJ_J9DjMB7AP_v-cp8coG3CACo5Wt4vQ@mail.gmail.com>
Message-ID: <9956925.Qsz2bH3rDg@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, May 26, 2014 11:59:09 AM Viresh Kumar wrote:
> On 23 May 2014 21:44, S?ren Brinkmann <soren.brinkmann@xilinx.com> wrote:
> > Viresh: Could you imagine something similar for cpufreq? You suggested
> > migrating to Hz resolution. I guess that would ideally mean to follow
> > the CCF to a 64-bit type for frequencies and increasing the resolution.
> > I have a messy patch migrating cpufreq and OPP to Hz and unsigned long
> > that works on Zynq. But cpufreq has so many users that it would become
> > quite an undertaking.
> > And we'd need some new/amended OPP DT binding.
> 
> If we are going to migrate to Hz from KHz, I think we must consider the
> 64 bit stuff right now, otherwise it will bite us later.
> 
> @Rafael: What do you think?

I agree as far as the 64-bit thing goes, but is switching to Hz really
necessary?

Rafael
