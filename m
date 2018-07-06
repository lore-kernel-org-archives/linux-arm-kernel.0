From: richard@nod.at (Richard Weinberger)
Date: Fri, 06 Jul 2018 16:49:55 +0200
Subject: [PATCH] mtd: stm32-quadspi: replace "%p" with "%pK"
In-Reply-To: <20180706164732.5776df5a@bbrezillon>
References: <20180706130525.22223-1-benjamin.gaignard@st.com>
 <32602293.7BQn8HeLUA@blindfold> <20180706164732.5776df5a@bbrezillon>
Message-ID: <1574993.BxlVuaNddV@blindfold>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag, 6. Juli 2018, 16:47:32 CEST schrieb Boris Brezillon:
> On Fri, 06 Jul 2018 16:44:44 +0200
> Richard Weinberger <richard@nod.at> wrote:
> 
> > Am Freitag, 6. Juli 2018, 15:05:25 CEST schrieb Benjamin Gaignard:
> > > The format specifier "%p" can leak kernel addresses.
> > > Use "%pK" instead.  
> > 
> > Does %pK really make sense for dev_dbg()?
> > When the driver is being debugged "leaking" is on purpose. :)
> 
> %p already gives you a hash of the pointer address. At least with %pK
> you can turn it off through a sysctl :).

Once again I mixed %p and %pK.
So then %pK is what we want. :D

Thanks,
//richard
