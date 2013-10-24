From: matt.porter@linaro.org (Matt Porter)
Date: Thu, 24 Oct 2013 15:52:19 -0400
Subject: [Ksummit-2013-discuss] ARM topic: Is DT on ARM the solution, or
 is there something better?
In-Reply-To: <1382622360.6040.79.camel@sakura.staff.proxad.net>
References: <20131023174458.GC5208@netboy>
 <1382553982.31058.10.camel@sakura.staff.proxad.net>
 <20131024095232.27BBCC4039D@trevor.secretlab.ca>
 <1382614439.6040.16.camel@sakura.staff.proxad.net>
 <1382615278.8522.72.camel@shinybook.infradead.org>
 <1382616801.6040.26.camel@sakura.staff.proxad.net>
 <3726fd81259f84ef308ba9011ae35174.squirrel@twosheds.infradead.org>
 <1382619952.6040.57.camel@sakura.staff.proxad.net>
 <addbb1933c62983e0114eeda7ce51342.squirrel@twosheds.infradead.org>
 <1382622360.6040.79.camel@sakura.staff.proxad.net>
Message-ID: <20131024195219.GY29341@beef>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 24, 2013 at 03:46:00PM +0200, Maxime Bizon wrote:
> 
> On Thu, 2013-10-24 at 13:14 +0000, David Woodhouse wrote:
> 
> > If DMA gives a performance boost for all workloads, what bloody idiot
> > defined or reviewed a DT binding that didn't include the information which
> 
> who defined it:
>   - hobbyist programmer without DMA knowledge 
>   - hobbyist programmer without time
>   - hobbyist programmer without datasheet access
>   - SOC-vendor employed programmer with deadline
> 
> who reviewed it:
>   - someone without time
>   - someone without datasheet access
>   - no-one (programmer was part of DT team :)

One more for each list:
    - professional programmer without datasheet access

I don't have docs for the parts I'm paid to work on. There's lots of
reasons why we don't know *all* information on day 0 and the notion of
binding perfection is flawed.

-Matt
