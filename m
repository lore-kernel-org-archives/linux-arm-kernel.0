From: paul@pwsan.com (Paul Walmsley)
Date: Sun, 21 Oct 2012 17:06:27 +0000 (UTC)
Subject: OMAP baseline test results for v3.7-rc2
In-Reply-To: <alpine.DEB.2.00.1210202125300.774@utopia.booyaka.com>
References: <alpine.DEB.2.00.1210202125300.774@utopia.booyaka.com>
Message-ID: <alpine.DEB.2.00.1210211704170.26128@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 20 Oct 2012, Paul Walmsley wrote:

> Here are some basic OMAP test results for Linux v3.7-rc2.
> Logs and other details at:
> 
>     http://www.pwsan.com/omap/testlogs/test_v3.7-rc2/20121020134755/

...

> Failing tests: needing investigation
> ------------------------------------
> 
> PM tests:
> 
> * 37xx EVM: CORE not entering dynamic off-idle
>   - Cause unknown; dynamic retention-idle seems to work; system suspend to 
>     off works

Just confirmed that this longstanding bug affects both MMC root and NFS 
root.


- Paul
