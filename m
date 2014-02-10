From: nm@ti.com (Nishanth Menon)
Date: Mon, 10 Feb 2014 12:00:05 -0600
Subject: OMAP baseline test results for v3.14-rc1
In-Reply-To: <alpine.DEB.2.02.1402101733340.30435@utopia.booyaka.com>
References: <alpine.DEB.2.02.1402101733340.30435@utopia.booyaka.com>
Message-ID: <52F913A5.7040207@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/10/2014 11:48 AM, Paul Walmsley wrote:
[...]
> Boot to userspace:
>     FAIL ( 1/10): 2430sdp

Comparing boot logs I reported
http://marc.info/?l=linux-omap&m=139144642318949&w=2 Vs
http://www.pwsan.com/omap/testlogs/test_v3.14-rc1/20140210035354/boot/2430sdp/2430sdp_log.txt

I see that bootargs are different -> I was attempting to boot sdp2430
with nfs boot which seems to work fine for me, I believe you are
attempting mmc boot here.


-- 
Regards,
Nishanth Menon
