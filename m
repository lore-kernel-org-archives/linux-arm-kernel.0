From: olof@lixom.net (Olof Johansson)
Date: Mon, 15 Oct 2012 21:14:27 -0700
Subject: [PATCH for 3.7] dtb: fix interrupt assignment for ehci/uhci on
 wm8505
In-Reply-To: <1350104430.6448.3.camel@gitbox>
References: <1350101882-6195-1-git-send-email-linux@prisktech.co.nz>
 <1350104430.6448.3.camel@gitbox>
Message-ID: <20121016041427.GB16114@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 13, 2012 at 06:00:30PM +1300, Tony Prisk wrote:
> On Sat, 2012-10-13 at 17:18 +1300, Tony Prisk wrote:
> > EHCI and UHCI devices in wm8505.dtsi should use IRQ 0 & 1
> > respectively - not 43 as used on newer models.
> 
> Oops - should have been IRQ 1 & 0 - fixed locally.
> > 
> > Signed-off-by: Tony Prisk <linux@prisktech.co.nz>

Applied to fixes with the commit message edited as above.


Thanks,

-Olof
