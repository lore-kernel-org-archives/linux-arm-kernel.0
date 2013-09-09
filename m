From: b32955@freescale.com (Huang Shijie)
Date: Mon, 9 Sep 2013 11:07:37 +0800
Subject: [PATCH v3 0/8] Add the Quadspi driver for vf610-twr
In-Reply-To: <20130908134725.GQ29403@sirena.org.uk>
References: <593AEF6C47F46446852B067021A273D6D984000B@MUCSE039.lantiq.com>
 <20130905020435.GA3970@gmail.com>
 <20980858CB6D3A4BAE95CA194937D5E73EA0C7F4@DBDE04.ent.ti.com>
 <522817D7.1010206@freescale.com>
 <20980858CB6D3A4BAE95CA194937D5E73EA0C885@DBDE04.ent
Message-ID: <522D3B79.3060707@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2013?09?08? 21:47, Mark Brown ??:
> On Thu, Sep 05, 2013 at 10:36:44PM -0400, Huang Shijie wrote:
>> On Thu, Sep 05, 2013 at 02:50:32PM +0100, Mark Brown wrote:
>>> Looking at the current header there just seem to be defines in there, no
>>> abstraction for the chips.  Perhaps that is what is missing?
>> we do not need any abstraction for this chip, we only need the SPI NOR 
>> commands, such as Quad read / DDR quad read.
> So the abstraction could say what the commands are, or what's supported
thanks.

I have already added the comment for what the commands are, please see
patch 3 & patch 4.
> if they're standard?
In actually, there is no standard for the SPI NOR commands now.

I added these commands just in the Spansion section now.
(Of course, other NOR vendors may also uses the same commands.)

thanks
Huang Shijie
