From: sylvain.rochet@finsecur.com (Sylvain Rochet)
Date: Thu, 12 Mar 2015 19:53:36 +0100
Subject: [PATCH 2/6] pm: at91: move the copying the sram function to the
 sram initializationi phase
In-Reply-To: <20150306232224.GA7475@gradator.net>
References: <1423709123-8033-1-git-send-email-wenyou.yang@atmel.com>
 <1423709209-8108-1-git-send-email-wenyou.yang@atmel.com>
 <20150306232224.GA7475@gradator.net>
Message-ID: <20150312185336.GA30371@gradator.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Wenyou,

On Sat, Mar 07, 2015 at 12:22:24AM +0100, Sylvain Rochet wrote:
> Hello Wenyou,
> 
> On Thu, Feb 12, 2015 at 10:46:49AM +0800, Wenyou Yang wrote:
> > To decrease the suspend time, move copying the sram function to the sram
> > initialization phase, instead of every time go to suspend.
> > 
> > In the meanwhile, substitute fncpy() for memcpy().
> > 
> > If there is no sram allocated for PM, the PM is not supported.
> 
> My board doesn't boot anymore with this change, I am not equipped enough 
> to debug more, looks like fncpy() is writing the function on top of 
> existing kernel code.
> 
> You said you had issues with fncpy(), I guess I am having the issue you 
> had.

A make clean later, it works? sorry for the mess.

Sylvain
