From: will.deacon@arm.com (Will Deacon)
Date: Wed, 5 Jun 2013 10:59:53 +0100
Subject: [PATCH] ARM: pcpu: ensure __my_cpu_offset cannot be re-ordered
 across barrier()
In-Reply-To: <alpine.LFD.2.03.1306041336060.1200@syhkavp.arg>
References: <1370278405-13261-1-git-send-email-will.deacon@arm.com>
 <alpine.LFD.2.03.1306031339010.1200@syhkavp.arg>
 <20130604103953.GL27516@mudshark.cambridge.arm.com>
 <20130604171506.GZ27516@mudshark.cambridge.arm.com>
 <alpine.LFD.2.03.1306041336060.1200@syhkavp.arg>
Message-ID: <20130605095953.GB8577@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 04, 2013 at 06:39:42PM +0100, Nicolas Pitre wrote:
> On Tue, 4 Jun 2013, Will Deacon wrote:
> > I spoke to the tools guys and they'll look into why the original patch
> > didn't work, since that could have wider implications on our use of
> > barrier().
> 
> Good.  However, given the wide range of gcc versions exhibiting the same 
> behavior, I think your patch is the best way forward even if gcc were to 
> be broken and eventually fixed.
> 
> Reviewed-by: Nicolas Pitre <nico@linaro.org>

Thanks Nicolas.

> I'd suggest queuing it for stable as well.

Will do.

Will
