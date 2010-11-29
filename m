From: cbouatmailru@gmail.com (Anton Vorontsov)
Date: Mon, 29 Nov 2010 18:32:32 +0300
Subject: [PATCH v3 1/1] USB: cns3xxx: Add EHCI and OHCI bus glue for
	cns3xxx SOCs
In-Reply-To: <AANLkTik7tZen0R51tvjhGamp_e9ue_Xh09S-EGsoWPUT@mail.gmail.com>
References: <20101125171541.GA18152@suse.de>
	<Pine.LNX.4.44L0.1011251521310.26094-100000@netrider.rowland.org>
	<20101126151131.GA26602@oksana.dev.rtsoft.ru>
	<20101126170348.GA3331@suse.de>
	<20101126182328.GA20923@oksana.dev.rtsoft.ru>
	<AANLkTinocHZBS4O7A2vhc-p6qX0wt04EfAi5Q2xgxSJW@mail.gmail.com>
	<AANLkTik7tZen0R51tvjhGamp_e9ue_Xh09S-EGsoWPUT@mail.gmail.com>
Message-ID: <20101129153232.GA5161@oksana.dev.rtsoft.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 29, 2010 at 11:58:15AM +0800, Lin Mac wrote:
[...]
> > +        * Set USB AHB INCR length to 16
> > +        */
> > +       if (atomic_inc_return(&usb_pwr_ref) == 0) {
> There's a typo here, the 0 should be 1 instead.

That was it. It works now.

[...]
> Should I resend the patch?

No need to, I've fixed the original commit.

Thanks!

-- 
Anton Vorontsov
Email: cbouatmailru at gmail.com
