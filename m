From: graeme.gregory@linaro.org (Graeme Gregory)
Date: Wed, 17 Sep 2014 09:05:08 -0700
Subject: [PATCH v4 18/18] Documentation: ACPI for ARM64
In-Reply-To: <20140917014410.GC31214@srcf.ucam.org>
References: <1410530416-30200-1-git-send-email-hanjun.guo@linaro.org>
 <1410530416-30200-19-git-send-email-hanjun.guo@linaro.org>
 <20140917014410.GC31214@srcf.ucam.org>
Message-ID: <20140917160508.GA2464@xora-yoga-13>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 17, 2014 at 02:44:10AM +0100, Matthew Garrett wrote:
> On Fri, Sep 12, 2014 at 10:00:16PM +0800, Hanjun Guo wrote:
> 
> > +Common _DSD bindings should be submitted to ASWG to be included in the
> > +document :-
> > +
> > +http://www.uefi.org/sites/default/files/resources/_DSD-implementation-guide-toplevel.htm
> 
> How are individuals/companies who aren't UEFI members supposed to do 
> this? Aren't there IP issues involved in taking submissions from 
> non-members?
> 

This section needs to be changed anyway, it comes out of a
misunderstanding I had of the _DSD spec.

It sounds like from the discussions in other threads that ARM64 should
be following x86 and re-using DT bindings here. In which case there is
not need to submit things to UEFI organisation.

What I got a little lost in has there been a formal decision about DT
bindings in _DSD?

Graeme
