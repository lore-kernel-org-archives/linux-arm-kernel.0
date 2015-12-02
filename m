From: eric.dumazet@gmail.com (Eric Dumazet)
Date: Wed, 02 Dec 2015 08:59:40 -0800
Subject: [PATCH 3/6] net: thunderx: Increase transmit queue length
In-Reply-To: <CA+sq2CfWC0kcxKj1kqMEU3+y9aovqDdpn2G72n5ON9T3Hzew_w@mail.gmail.com>
References: <01d101d12c46$2de43b40$89acb1c0$@samsung.com>
 <1448983985.25582.35.camel@edumazet-glaptop2.roam.corp.google.com>
 <CA+sq2Ce9oH-kCDO8hK_wX+ZZdXyyBuT4V2bt5Ab+2=pEX+BO+w@mail.gmail.com>
 <20151201.143047.82022857078130793.davem@davemloft.net>
 <CA+sq2CduMnsh_R9zTRMjWT=F5=9U3si-5nO6-gFvGCO9czkDdA@mail.gmail.com>
 <1449062733.32764.53.camel@edumazet-glaptop2.roam.corp.google.com>
 <CA+sq2CfWC0kcxKj1kqMEU3+y9aovqDdpn2G72n5ON9T3Hzew_w@mail.gmail.com>
Message-ID: <1449075580.6379.1.camel@edumazet-glaptop2.roam.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2015-12-02 at 22:20 +0530, Sunil Kovvuri wrote:
> >
> > If the performance increase is 4 %, then surely using twice more memory
> > is not worth it.
> I haven't mentioned anywhere that i am seeing 4% increase in performance.

Yes, this is the complain I made :

No numbers, just a patch increasing ring size by a 100% factor !

I really hope you'll have very convincing numbers, especially if your
driver does not implement BQL.
