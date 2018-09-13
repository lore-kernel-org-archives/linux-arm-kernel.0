From: Jisheng.Zhang@synaptics.com (Jisheng Zhang)
Date: Thu, 13 Sep 2018 15:33:50 +0800
Subject: [4.14.y] request commit 94a5d8790e79 ("arm64: cpu_errata:
 include required headers")
In-Reply-To: <20180913152420.6c6324f4@xhacker.debian>
References: <20180911170030.650928d8@xhacker.debian>
 <20180913071216.GH11496@kroah.com>
 <20180913152420.6c6324f4@xhacker.debian>
Message-ID: <20180913153350.0adc1c48@xhacker.debian>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 13 Sep 2018 15:24:20 +0800 Jisheng Zhang wrote:

> Hi Greg,
> 
> On Thu, 13 Sep 2018 09:12:16 +0200 Greg Kroah-Hartman wrote:
> 
> > On Tue, Sep 11, 2018 at 05:00:30PM +0800, Jisheng Zhang wrote:  
> > > Hi Greg,
> > > 
> > > I think we missed the commit 94a5d8790e79 ("arm64: cpu_errata: include
> > > required headers"), could you please include it in next stable release?    
> > 
> > Really, you are seeing build failures on 4.14.y without this patch
> > applied?  I haven't gotten any reports of this, what is wrong with our  
> 
> yes. I see similar build errors as the commit mentioned. Per my test, setting
> CONFIG_ARM64_SSBD as y will trigger the errors.

hmm, it looks like the defconfig in arch/arm64/configs can't trigger the
build errors. But my version could, I attach it for reference.

> 
> Thanks
> 
> > build tests that this isn't being caught?
> > 
> > thanks,
> > 
> > greg k-h  
> 

-------------- next part --------------
A non-text attachment was scrubbed...
Name: config_bad.gz
Type: application/gzip
Size: 12599 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180913/df4b8b49/attachment-0001.gz>
