From: horms@verge.net.au (Simon Horman)
Date: Mon, 25 Mar 2013 16:44:20 +0900
Subject: [PATCH 00/04] ARM: shmobile: r8a7790 SoC and Lager board support
In-Reply-To: <514AF14A.4020308@cogentembedded.com>
References: <20130320143604.32377.32634.sendpatchset@w520>
 <514AF14A.4020308@cogentembedded.com>
Message-ID: <20130325074417.GA23486@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 21, 2013 at 03:38:50PM +0400, Sergei Shtylyov wrote:
> Hello.
> 
> On 20-03-2013 18:36, Magnus Damm wrote:
> 
> >ARM: shmobile: r8a7790 SoC and Lager board support
> 
> >[PATCH 01/04] ARM: shmobile: Initial r8a7790 SoC support
> >[PATCH 02/04] ARM: shmobile: r8a7790 SCIF support
> >[PATCH 03/04] ARM: shmobile: r8a7790 IRQC support
> >[PATCH 04/04] ARM: shmobile: Lager support
> >
> >This series adds initial support for r8a7790 and Lager. The SoC
> >is known as r8a7790 which is built around Cortex-A15 and makes use
> >of SCIF for serial and IRQC interrupt controller for external IRQs.
> 
>    Is it the same as R-Car H2?

Yes, I believe so.
