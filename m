From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 23 Apr 2013 17:56:03 -0400 (EDT)
Subject: [PATCH v4 00/15] multi-cluster power management
In-Reply-To: <20130423214610.GY14496@n2100.arm.linux.org.uk>
References: <1360041732-17936-1-git-send-email-nicolas.pitre@linaro.org>
 <20130423200429.GF5316@n2100.arm.linux.org.uk>
 <alpine.LFD.2.03.1304231657150.17375@syhkavp.arg>
 <20130423214610.GY14496@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.03.1304231755370.17375@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 23 Apr 2013, Russell King - ARM Linux wrote:

> On Tue, Apr 23, 2013 at 05:03:06PM -0400, Nicolas Pitre wrote:
> > On Tue, 23 Apr 2013, Russell King - ARM Linux wrote:
> > 
> > > What I suggest for the time being is to provide new inline function(s)
> > > in arch/arm/include/cacheflush.h which are purposed for your application,
> > > document them in that file, and call the implementation you're currently
> > > using.  That means if we do have to change it in the future (for example,
> > > we don't need to do anything in the dcache flushing stuff) we don't have
> > > to hunt through all the code to find _your_ different use of that function
> > > and fix it - we can just fix it in one place and we have the reference
> > > there for what your code expects.
> > 
> > What about the patch below?  Once you tell me it is fine to you I'll 
> > adapt the MCPM series to it.
> 
> Yes, that looks like a saner solution.  Thanks.

May I add your ACK to the patch?


Nicolas
