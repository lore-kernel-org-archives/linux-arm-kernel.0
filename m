From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 17 Jan 2013 17:55:31 +0000
Subject: [PATCH 00/16] big.LITTLE low-level CPU and cluster power
 management
In-Reply-To: <alpine.LFD.2.02.1301161614390.6300@xanadu.home>
References: <1357777251-13541-1-git-send-email-nicolas.pitre@linaro.org>
 <1358157392.19304.243.camel@jlo-ubuntu-64.nvidia.com>
 <alpine.LFD.2.02.1301140849020.6300@xanadu.home>
 <1358217848.8513.14.camel@jlo-ubuntu-64.nvidia.com>
 <alpine.LFD.2.02.1301151140550.6300@xanadu.home>
 <20130116160242.GB31318@arm.com>
 <alpine.LFD.2.02.1301161614390.6300@xanadu.home>
Message-ID: <20130117175531.GD5737@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 16, 2013 at 09:18:39PM +0000, Nicolas Pitre wrote:
> On Wed, 16 Jan 2013, Catalin Marinas wrote:
> 
> > On Tue, Jan 15, 2013 at 04:44:23PM +0000, Nicolas Pitre wrote:
> > > On Tue, 15 Jan 2013, Joseph Lo wrote:
> > > > So do you have a plan to make it become a generic framework in this
> > > > series or later work?
> > > 
> > > It is already generic, except for the name.  In other words, you could 
> > > start using this code already.
> > > 
> > > I'm still debating a good substitute for the bL_ prefix in this series 
> > > to give it the appearance of generic code.
> > 
> > mc_?
> 
> Bah.   :-/

Like in multi-cluster (not "Hammer time" ;). But if they are not even
cluster dependent, a simple mp_ would also do.

-- 
Catalin
