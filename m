From: robert.richter@caviumnetworks.com (Robert Richter)
Date: Thu, 18 Feb 2016 17:42:17 +0100
Subject: [PATCH 2/2] net, thunderx: Use bool in structs where possible
In-Reply-To: <20160218.110514.652169911099659792.davem@davemloft.net>
References: <1455799149-19590-1-git-send-email-rrichter@caviumnetworks.com>
 <1455799149-19590-3-git-send-email-rrichter@caviumnetworks.com>
 <20160218.110514.652169911099659792.davem@davemloft.net>
Message-ID: <20160218164217.GP24726@rric.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18.02.16 11:05:14, David Miller wrote:
> From: Robert Richter <rrichter@caviumnetworks.com>
> Date: Thu, 18 Feb 2016 13:39:09 +0100
> 
> > From: Robert Richter <rrichter@cavium.com>
> > 
> > Looks like the :1 notation was accidentally introduced (this still
> > uses 1 byte per flag). Using bool instead, which is the common use.
> > 
> > Signed-off-by: Robert Richter <rrichter@cavium.com>
> 
> Such cleanups are not appropriate for 'net'.  Only real bug fixes should
> be targetted that.
> 
> Respin these patches targetting the correct tree(s).

Do you mean posting the two as "trivial" patches?

Thanks,

-Robert
