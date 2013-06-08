From: davem@davemloft.net (David Miller)
Date: Sat, 08 Jun 2013 11:18:53 -0700 (PDT)
Subject: [PATCH 0/9] sh_eth: make driver build on any platform
In-Reply-To: <51B32D76.1030507@cogentembedded.com>
References: <51B277A7.4010709@cogentembedded.com>
 <20130607.233915.1771016084489204040.davem@davemloft.net>
 <51B32D76.1030507@cogentembedded.com>
Message-ID: <20130608.111853.1706293535392213403.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Sat, 08 Jun 2013 17:11:18 +0400

>    Hold on please. It just occured to me that the series won't be
>    bisectable on anything but R-Car CPUs (I checked it only on R8A7779)
>    since I forgot that 'sh_eth_my_cpu_data' variable should be always
>    available in any configuuration until the last patch (so the patch #1
>    is somewhat incomplete). I'll respin the series today and resend.

Too late, it's already pushed to my tree and at that point it's permanent.
