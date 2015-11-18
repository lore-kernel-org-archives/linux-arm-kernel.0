From: atull@opensource.altera.com (atull)
Date: Wed, 18 Nov 2015 11:01:25 -0600
Subject: [PATCH] fpga: zynq-fpga: Avoid hammering clk_{enable/disable}.
In-Reply-To: <CAAtXAHfLZ1DTtp5sMJAn=G26dEv7np-tN_fKPGxdFsO0uPq+eA@mail.gmail.com>
References: <1447780317-27758-1-git-send-email-moritz.fischer@ettus.com>
 <564B6988.5020104@xilinx.com>
 <CAAtXAHfLZ1DTtp5sMJAn=G26dEv7np-tN_fKPGxdFsO0uPq+eA@mail.gmail.com>
Message-ID: <alpine.DEB.2.02.1511181057590.9049@linuxheads99>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Tue, 17 Nov 2015, Moritz Fischer wrote:

> > Body has nothing specific what it is available only for CONFIG_PM that's
> > why it should just work.
> 
> You're right. I'll resubmit once other people took another look. Not
> high priority ;-)
> 
> Cheers,
> 
> Moritz
> 

Hi Moritz,

Looks good to me with only the minor nit that the patch subject line
could say that you are enabling suspend/resume or something.

Acked-by: Alan Tull <atull@opensource.altera.com>

Alan
