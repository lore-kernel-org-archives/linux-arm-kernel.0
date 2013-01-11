From: dave.martin@linaro.org (Dave Martin)
Date: Fri, 11 Jan 2013 11:38:24 +0000
Subject: [PATCH 14/16] ARM: TC2: ensure powerdown-time data is flushed
 from cache
In-Reply-To: <alpine.LFD.2.02.1301101410540.6300@xanadu.home>
References: <1357777251-13541-1-git-send-email-nicolas.pitre@linaro.org>
 <1357777251-13541-15-git-send-email-nicolas.pitre@linaro.org>
 <20130110185052.GF29952@linaro.org>
 <alpine.LFD.2.02.1301101410540.6300@xanadu.home>
Message-ID: <20130111113824.GF1966@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 10, 2013 at 02:13:09PM -0500, Nicolas Pitre wrote:
> On Thu, 10 Jan 2013, Dave Martin wrote:
> 
> > On Wed, Jan 09, 2013 at 07:20:49PM -0500, Nicolas Pitre wrote:
> > > From: Dave Martin <dave.martin@linaro.org>
> > 
> > To avoid confusion, the prefix in the subject line should be "CCI", not
> > "TC2".
> 
> Absolutely.  This is my mistake as I removed the TC2 changes from your 
> original patch to only keep the CCI ones, but forgot to update the patch 
> title.

Oh right.  I was quite happy to believe it was my mistake :)

It makes sense to have two separate patches anyway, though.

Cheers
---Dave
