From: Wenyou.Yang@atmel.com (Yang, Wenyou)
Date: Mon, 5 Jan 2015 03:32:42 +0000
Subject: AT91 slow clock mode regression/fixes, improvement proposal
In-Reply-To: <B256D81BAE5131468A838E5D7A243641BFCB6CA0@penmbx01>
References: <20141218203904.GA25215@gradator.net>
 <B256D81BAE5131468A838E5D7A243641BFCB6762@penmbx01>
 <20141219152625.GA30666@gradator.net>
 <B256D81BAE5131468A838E5D7A243641BFCB6CA0@penmbx01>
Message-ID: <B256D81BAE5131468A838E5D7A243641BFCD1D0C@penmbx01>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sylvain,

> > Furthermore, it looks like MCKRDY_TIMEOUT set to 1000 is not
> > > > enough, my board crashes in about 1 wake up to 10 with this value
> > > > and works perfectly fine with 4000.
> > >
> > > I also encountered this issue.
> >
> > Fixed in proposed patch, since we don't timeout anymore.
> I am verifying this patch. I still insist on remain the timeout.
>
Verified OK.

Thanks.

I remembered you said this patch is not formal. Now, would you like send a formal one?

Best Regards,
Wenyou Yang
