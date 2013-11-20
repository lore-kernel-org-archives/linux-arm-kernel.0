From: eric.dumazet@gmail.com (Eric Dumazet)
Date: Tue, 19 Nov 2013 16:08:49 -0800
Subject: [BUG,REGRESSION?] 3.11.6+,3.12: GbE iface rate drops to few KB/s
In-Reply-To: <874n780wzc.fsf@natisbad.org>
References: <87a9hagex1.fsf@natisbad.org> <20131112100126.GB23981@1wt.eu>
 <87vbzxd473.fsf@natisbad.org> <20131113072257.GB10591@1wt.eu>
 <20131117141940.GA18569@1wt.eu>
 <1384710098.8604.58.camel@edumazet-glaptop2.roam.corp.google.com>
 <87li0kkhzx.fsf@natisbad.org>
 <1384869194.8604.92.camel@edumazet-glaptop2.roam.corp.google.com>
 <20131119174323.GH913@1wt.eu>
 <1384885910.8604.110.camel@edumazet-glaptop2.roam.corp.google.com>
 <20131119184121.GN913@1wt.eu> <874n780wzc.fsf@natisbad.org>
Message-ID: <1384906129.8604.132.camel@edumazet-glaptop2.roam.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2013-11-20 at 00:53 +0100, Arnaud Ebalard wrote:

> Anyway, I think if the thread keeps going on improving mvneta, I'll do
> all additional tests from RAM and will stop polluting netdev w/ possible
> sata/disk/fs issues.

;)

Alternative would be to use netperf or iperf to not use disk at all
and focus on TCP/network issues only.

Thanks !
