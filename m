From: paul@pwsan.com (Paul Walmsley)
Date: Tue, 28 Feb 2012 03:33:47 -0700 (MST)
Subject: [PATCHv2 2/6] ARM: OMAP4 PM: Add IO Daisychain support
In-Reply-To: <1330096546-20477-3-git-send-email-t-kristo@ti.com>
References: <1330096546-20477-1-git-send-email-t-kristo@ti.com>
 <1330096546-20477-3-git-send-email-t-kristo@ti.com>
Message-ID: <alpine.DEB.2.00.1202280332460.11716@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi 

a minor comment

On Fri, 24 Feb 2012, Tero Kristo wrote:

>  
> +/**
> + * Maximum time(us) it takes to output the signal WUCLKOUT of the last pad of
> + * the I/O ring after asserting WUCLKIN high
> + */

This is not a kerneldoc comment, so it's best not to use a double asterisk 
on the start line.


- Paul
