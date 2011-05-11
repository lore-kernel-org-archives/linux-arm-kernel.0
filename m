From: vinod.koul@intel.com (Koul, Vinod)
Date: Wed, 11 May 2011 22:23:20 +0530
Subject: [PATCH] dmaengine: at_hdmac: pause: no need to wait for FIFO empty
In-Reply-To: <4DC929EC.6040706@atmel.com>
References: <be7d19459501aaa604aebe91daa9e9e59bb41c86.1304704588.git.nicolas.ferre@atmel.com>
	<1304957497-22814-1-git-send-email-nicolas.ferre@atmel.com>
	<4DC927DF.1060808@ru.mvista.com>  <4DC929EC.6040706@atmel.com>
Message-ID: <1305132800.28926.53.camel@vkoul-udesk3>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2011-05-10 at 14:05 +0200, Nicolas Ferre wrote:
> Le 10/05/2011 13:56, Sergei Shtylyov :
> > Hello.
> > 
> > On 09-05-2011 20:11, Nicolas Ferre wrote:
> > 
> >> The addition of the pause feature to atc_control an active wait was
> >> introduced
> >> to check the FIFO empty event.
> > 
> >    Couldn't parse this -- did you forget "with"at the start of the
> > statement?
> 
> Absolutely. A comma can also improve things... is it better like this?
> 
> "
> With the addition of the "pause" feature, an active wait loop was
> introduced to check the "FIFO empty" event.
> "
> 
> Vinod, tell me if you want me to send a new patch.
Its okay, I can fix the commit


-- 
~Vinod
