From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Wed, 26 Feb 2014 22:00:36 +0100
Subject: [PATCH 1/7] Documentation: dt: iio: improve atmel-adc
 documentation
In-Reply-To: <20140226173904.GG607@lukather>
References: <1393434074-15600-1-git-send-email-alexandre.belloni@free-electrons.com>
 <20140226173904.GG607@lukather>
Message-ID: <20140226210035.GD20517@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 26/02/2014 at 18:39:04 +0100, Maxime Ripard wrote :
> Hi Alexandre,
> 
> On Wed, Feb 26, 2014 at 06:01:08PM +0100, Alexandre Belloni wrote:
> > This corrects the example by removing the unit-address, as suggested by Mark
> > Rutland in
> > http://lists.infradead.org/pipermail/linux-arm-kernel/2014-February/234184.html
> 
> I still belive that it's wrong, and Mark haven't answered my comments
> on his statement.
> 

After our discussion, I'll go for the other suggestion, I'll add
#address-cells, #size-cells and a reg for each trigger.

> I'd vote for a status-quo, until he gives an answer backed with
> references to the ePAPR.
> 
> > 
> > Also, it removes the properties that are not used anymore, to stop propagating
> > them.
> > 
> > Finally, fixes a few typos.
> 
> I'm fine with the rest.
> 
> Maxime
> 
> 
> -- 
> Maxime Ripard, Free Electrons
> Embedded Linux, Kernel and Android engineering
> http://free-electrons.com



> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel


-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140226/0202b047/attachment.sig>
