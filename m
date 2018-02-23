From: andrew@aj.id.au (Andrew Jeffery)
Date: Fri, 23 Feb 2018 10:41:07 +1030
Subject: [PATCH] MAINTAINERS: Update ASPEED entry with details
In-Reply-To: <23b668f1-ab4b-7ef3-ba1e-f252fbba4d1b@linux.intel.com>
References: <20180222050324.21531-1-joel@jms.id.au>
 <1519288786.101739.1279390200.1CD3EC51@webmail.messagingengine.com>
 <23b668f1-ab4b-7ef3-ba1e-f252fbba4d1b@linux.intel.com>
Message-ID: <1519344667.1024159.1280347184.36AD3FEC@webmail.messagingengine.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Haiyue,

On Thu, 22 Feb 2018, at 19:20, Wang, Haiyue wrote:
> Dear Andrew & Joel,
> 
> Since you are ASPEED BMC experts, any time and interest in eSPI code 
> review ? I've sent
> 
> it before, but no more response. Intel recommends eSPI bus than LPC as I 
> know. I just kept
> 
> the minimal eSPI code which is approved to work well in our real server 
> boards for two more
> 
> years. Other part of eSPI driver from ASPEED's SDK? has been removed, 
> because ePSI is a new
> 
> thing, we only use a small feature set like booting host.
> 
> We Intel submit this eSPI patch for openbmc upstreaming, hope for your 
> response. :-)
> 
> https://patchwork.kernel.org/patch/10166577/
> 

There are some comments against the v1 that you linked to above, is there a v2 on the lists?

Separately it's better to ping us by replying to the patch itself and putting us in To/Cc, that way we keep discussions focused on the patch at hand here.

Cheers,

Andrew
