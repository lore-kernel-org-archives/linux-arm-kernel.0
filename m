From: heiko@sntech.de (Heiko Stuebner)
Date: Thu, 12 May 2016 10:30:25 +0200
Subject: [PATCH v8 8/8] i2c: rk3x: support fast-mode plus for rk3399
In-Reply-To: <CAD=FV=VzQ8PRokgAaTV00L31mcXFEzBG8c1NB4+Rqyx75hwwDg@mail.gmail.com>
References: <1462908252-27016-1-git-send-email-david.wu@rock-chips.com>
 <5153288.jNhUuzGC3g@phil>
 <CAD=FV=VzQ8PRokgAaTV00L31mcXFEzBG8c1NB4+Rqyx75hwwDg@mail.gmail.com>
Message-ID: <6806722.VBDbziL6YI@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, 11. Mai 2016, 16:41:54 schrieb Doug Anderson:
> Heiko,
> 
> On Wed, May 11, 2016 at 2:09 PM, Heiko Stuebner <heiko@sntech.de> wrote:
> > Additionally, the i2c-noob in me would wish for a short sentence on
> > where
> > the timing values come from (measured, somewhere in the TRM I didn't
> > find or something completely different).
> 
> If you search for "UM10204" you'll find the first link is
> <http://www.nxp.com/documents/user_manual/UM10204.pdf>.  That appears
> to be the official standard.  At least that's what
> <http://www.i2c-bus.org/fast-mode-plus/> says (though they have an old
> link).

I did find that document yesterday, but was to blind and somehow only saw the 
separate table for highspeed-timings. On a closer look, I now also found the 
timing-table for the other modes [due to the bigger font-size used there? 
;-) ]
