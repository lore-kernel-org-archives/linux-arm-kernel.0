From: paul@pwsan.com (Paul Walmsley)
Date: Thu, 10 Mar 2011 01:45:28 -0700 (MST)
Subject: [PATCH] OMAP4: hwmod: Disable hardware-controlled idle for
 GPT1
In-Reply-To: <alpine.DEB.2.00.1103091847150.15132@utopia.booyaka.com>
References: <alpine.DEB.2.00.1103091847150.15132@utopia.booyaka.com>
Message-ID: <alpine.DEB.2.00.1103100143230.15132@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 9 Mar 2011, Paul Walmsley wrote:

> From: Rajendra Nayak <rnayak@ti.com>
> 
> Some issues seen (which cause lockups in suspend) with GPT1
> after the MPU<->L4_WKUP static dependency was cleared can be
> Worked-around for now by forcing GPT1 in software
> controlled idle.
> 
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> Signed-off-by: Beno?t Cousson <b-cousson@ti.com>
> Signed-off-by: Paul Walmsley <paul@pwsan.com>

Just a quick note, I missed Beno?t's update of the commit message:

    http://www.spinics.net/linux/lists/linux-omap/msg48008.html

and he's the maintainer of this so we should use his instead.  The revised 
message is below.


- Paul

OMAP4: hwmod data: Temporarily disable hardware-controlled idle for timer1
    
Some issues seen (which cause lockups in suspend) with timer1
after the MPU<->L4_WKUP static dependency was cleared can be
Worked-around for now by forcing timer1 in software
controlled idle.
    
Signed-off-by: Rajendra Nayak <rnayak@ti.com>
[b-cousson: Update the changelog and the subject]
Signed-off-by: Beno?t Cousson <b-cousson@ti.com>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
