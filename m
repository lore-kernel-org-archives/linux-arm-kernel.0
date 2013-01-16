From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Wed, 16 Jan 2013 16:18:39 -0500 (EST)
Subject: [PATCH 00/16] big.LITTLE low-level CPU and cluster power
 management
In-Reply-To: <20130116160242.GB31318@arm.com>
References: <1357777251-13541-1-git-send-email-nicolas.pitre@linaro.org>
 <1358157392.19304.243.camel@jlo-ubuntu-64.nvidia.com>
 <alpine.LFD.2.02.1301140849020.6300@xanadu.home>
 <1358217848.8513.14.camel@jlo-ubuntu-64.nvidia.com>
 <alpine.LFD.2.02.1301151140550.6300@xanadu.home>
 <20130116160242.GB31318@arm.com>
Message-ID: <alpine.LFD.2.02.1301161614390.6300@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 16 Jan 2013, Catalin Marinas wrote:

> On Tue, Jan 15, 2013 at 04:44:23PM +0000, Nicolas Pitre wrote:
> > On Tue, 15 Jan 2013, Joseph Lo wrote:
> > > So do you have a plan to make it become a generic framework in this
> > > series or later work?
> > 
> > It is already generic, except for the name.  In other words, you could 
> > start using this code already.
> > 
> > I'm still debating a good substitute for the bL_ prefix in this series 
> > to give it the appearance of generic code.
> 
> mc_?

Bah.   :-/


Nicolas
