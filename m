From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 29 Jan 2013 14:26:57 -0500 (EST)
Subject: [PATCH v3 07/15] ARM: vexpress: Select the correct SMP operations
 at run-time
In-Reply-To: <1359474220.3731.45.camel@linaro1.home>
References: <1359445870-18925-1-git-send-email-nicolas.pitre@linaro.org>
 <1359445870-18925-8-git-send-email-nicolas.pitre@linaro.org>
 <1359474220.3731.45.camel@linaro1.home>
Message-ID: <alpine.LFD.2.02.1301291425320.6300@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 29 Jan 2013, Jon Medhurst (Tixy) wrote:

> On Tue, 2013-01-29 at 02:51 -0500, Nicolas Pitre wrote:
> > From: Jon Medhurst <tixy@linaro.org>
> > 
> > Signed-off-by: Jon Medhurst <tixy@linaro.org>
> > ---
> 
> Should this patch be split into two. One to introduce the new smp_init
> hook into the generic ARM kernel code, and one to make vexpress use it?
> With, descriptions something like:
> 
> -----------------------------------------------------------------------
> ARM: kernel: Enable selection of SMP operations at boot time
> 
> Add a new 'smp_init' hook to machine_desc so platforms can specify a
> function to be used to setup smp ops instead of having a statically
> defined value.
> -----------------------------------------------------------------------
> ARM: vexpress: Select multi-cluster SMP operation if required
> -----------------------------------------------------------------------

That certainly makes sense.  Are you willing to split your patch as such 
and send me the result?


Nicolas
