From: dinguyen@altera.com (Dinh Nguyen)
Date: Wed, 18 Jun 2014 11:14:32 -0500
Subject: [PATCHv2] clk: socfpga: Add a second parent option for the
 dbg_base_clk
In-Reply-To: <20140617221138.32686.1282@quantum>
References: <1402714835-19861-1-git-send-email-dinguyen@altera.com>
 <20140617221138.32686.1282@quantum>
Message-ID: <1403108072.15124.0.camel@linux-builds1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike,

On Tue, 2014-06-17 at 15:11 -0700, Mike Turquette wrote:
> Quoting dinguyen at altera.com (2014-06-13 20:00:35)
> > From: Dinh Nguyen <dinguyen@altera.com>
> > 
> > The debug base clock can be bypassed from the main PLL to the OSC1 clock.
> > The bypass register is the staysoc1(0x10) register that is in the clock
> > manager.
> > 
> > This patch adds the option to get the correct parent for the debug base
> > clock.
> > 
> > Signed-off-by: Dinh Nguyen <dinguyen@altera.com>
> 
> Looks good to me.
> 
> Regards,
> Mike

Thanks for reviewing. Can you please apply it to your for-next?

Dinh
