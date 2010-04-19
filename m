From: mika.westerberg@iki.fi (Mika Westerberg)
Date: Mon, 19 Apr 2010 12:55:24 +0300
Subject: ep93xx SPI driver v3
In-Reply-To: <m2l56d259a01004190225k19080786t84f79a29d78795a9@mail.gmail.com>
References: <j2u56d259a01004151645y47ec8254ree59189aaa6b5baa@mail.gmail.com>
	<20100416042658.GK2685@gw.healthdatacare.com>
	<l2p56d259a01004160211m17bc0f10gc63a5ca82436c8e3@mail.gmail.com>
	<20100416094444.GC6718@gw.healthdatacare.com>
	<p2l56d259a01004160455jdf290557yd102cf78d9f1252e@mail.gmail.com>
	<20100416171032.GD6718@gw.healthdatacare.com>
	<r2j56d259a01004162023tdf8f226aw5aab98bd54c03ac0@mail.gmail.com>
	<4BCB7148.5040600@bluewatersys.com>
	<20100419064809.GF19534@gw.healthdatacare.com>
	<m2l56d259a01004190225k19080786t84f79a29d78795a9@mail.gmail.com>
Message-ID: <20100419095524.GG19534@gw.healthdatacare.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 19, 2010 at 10:25:03AM +0100, Martin Guy wrote:
> On 4/19/10, Mika Westerberg <mika.westerberg@iki.fi> wrote:
> >  BTW: do you guys think that there is any real use of polling mode
> >  in the driver or should I drop it out completely?
> 
> Is there any advantage to it in terms of transfer speed or CPU efficiency?

I guess no. At least for CPU efficiency.

Original motivation for implementing it was to let users choose which method they prefer
but now I have second thoughts about that since interrupt mode seems to perform OK and
I don't see any advantage of using polling here.

Thanks,
MW
