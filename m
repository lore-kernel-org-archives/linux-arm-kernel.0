From: nm@ti.com (Nishanth Menon)
Date: Tue, 12 May 2015 12:18:04 -0500
Subject: next-20150511 / omap2-mcspi: regression for sdp4430 boot
In-Reply-To: <20150511201633.GA31117@deathray>
References: <5550DDCB.8010303@ti.com> <20150511170742.GA6616@deathray>
 <5550F47C.1030902@ti.com> <20150511183032.GA8085@deathray>
 <5550FC38.6020801@ti.com> <20150511201633.GA31117@deathray>
Message-ID: <555235CC.9040706@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/11/2015 03:16 PM, Michael Welling wrote:
[...]
> Okay I have another patch that appears to fix the issue on my board.
> 
> Please test the attached patch and see if it fixes the issue on your board.
> 
> If it does, I will send it upstream.

Tested on: 20150512 http://paste.ubuntu.org.cn/2600365
Works :). Thanks for rootcausing and providing a fix.

-- 
Regards,
Nishanth Menon
