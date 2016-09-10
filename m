From: tony@atomide.com (Tony Lindgren)
Date: Sat, 10 Sep 2016 06:10:04 -0700
Subject: [4.8.0-rc1] am335x-evm boot failure: n_tty_receive_buf_common:
 "Unable to handle kernel paging request.."
In-Reply-To: <CAALWOA-e6SZEW67akn_EGnCPzfZbuw-wjwu-j1dfuucoCA5ecg@mail.gmail.com>
References: <87ceb885-94a6-b9b3-60b3-2017198c4338@ti.com>
 <CAALWOA_=9fMG156H_XSZBjeckQUK-moDWoRE6_kr-8=Z_-KZuA@mail.gmail.com>
 <20160909234742.becrs3zb4ihc2mq6@atomide.com>
 <CAALWOA-e6SZEW67akn_EGnCPzfZbuw-wjwu-j1dfuucoCA5ecg@mail.gmail.com>
Message-ID: <20160910131002.6zyzybd6kcklt6yx@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Matthijs van Duin <matthijsvanduin@gmail.com> [160909 16:54]:
> On 10 September 2016 at 01:47, Tony Lindgren <tony@atomide.com> wrote:
> > Yeah. Just disable omap_l3_smx/noc driver and you should see
> > a proper stack trace. With the L3 driver we're seeing the trace
> > for L3 error interrupt.
> 
> Huh what, I see a proper stack trace in his post? I'm pretty sure
> omap_l3_noc doesn't even support am335x currently.

Oh OK sorry please ignore the post, I obviously did not look at
the trace but assumed that was the case based on what I've seen.

Yeah I don't think we have L3 interrupts working for am335x.

Regards,

Tony
