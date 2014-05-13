From: horms@verge.net.au (Simon Horman)
Date: Tue, 13 May 2014 10:57:08 +0900
Subject: [PATCH v5 01/11] ARM: shmobile: r7s72100: document MSTP clock
 support
In-Reply-To: <20140513000513.5943.68810@quantum>
References: <1398765822-2314-1-git-send-email-wsa@the-dreams.de>
 <1398765822-2314-2-git-send-email-wsa@the-dreams.de>
 <20140513000513.5943.68810@quantum>
Message-ID: <20140513015708.GA29336@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 12, 2014 at 05:05:13PM -0700, Mike Turquette wrote:
> Quoting Wolfram Sang (2014-04-29 03:03:32)
> > From: Wolfram Sang <wsa+renesas@sang-engineering.com>
> > 
> > Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> 
> Acked-by: Mike Turquette <mturquette@linaro.org>
> 
> No need to take this through the clk tree. Feel free to send it with the
> rest through arm-soc.

Thanks Mike.

Wolfram,

Its a getting a little to close to rc6 for me to take this series for v3.16,
especially considering some bits seem to need tweaking (I am thinking of sci).

Could you either:

* Re-post it without the sci changes and
  I'll look at queuing it up for v3.17 or;
* Re-post it with the sci changes once the sci driver changes
  have filtered through.

> Regards,
> Mike
> 
> > ---
> >  Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt b/Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt
> > index 02a25d99ca61..6c3c0847e4fd 100644
> > --- a/Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt
> > +++ b/Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt
> > @@ -10,6 +10,7 @@ index in the group, from 0 to 31.
> >  Required Properties:
> >  
> >    - compatible: Must be one of the following
> > +    - "renesas,r7s72100-mstp-clocks" for R7S72100 (RZ) MSTP gate clocks
> >      - "renesas,r8a7790-mstp-clocks" for R8A7790 (R-Car H2) MSTP gate clocks
> >      - "renesas,r8a7791-mstp-clocks" for R8A7791 (R-Car M2) MSTP gate clocks
> >      - "renesas,cpg-mstp-clock" for generic MSTP gate clocks
> > -- 
> > 1.9.2
> > 
> > 
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel at lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
