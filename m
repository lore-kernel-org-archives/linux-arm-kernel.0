From: peter.griffin@linaro.org (Peter Griffin)
Date: Thu, 30 Jul 2015 10:47:38 +0100
Subject: [PATCH 02/12] [media] dvb-pll: Add support for THOMSON DTT7546X
 tuner.
In-Reply-To: <20150722185811.2d718baa@recife.lan>
References: <1435158670-7195-1-git-send-email-peter.griffin@linaro.org>
 <1435158670-7195-3-git-send-email-peter.griffin@linaro.org>
 <1435195057.9377.18.camel@perches.com>
 <20150722185811.2d718baa@recife.lan>
Message-ID: <20150730094738.GD488@griffinp-ThinkPad-X1-Carbon-2nd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mauro / Joe,

On Wed, 22 Jul 2015, Mauro Carvalho Chehab wrote:

> Em Wed, 24 Jun 2015 18:17:37 -0700
> Joe Perches <joe@perches.com> escreveu:
> 
> > On Wed, 2015-06-24 at 16:11 +0100, Peter Griffin wrote:
> > > This is used in conjunction with the STV0367 demodulator on
> > > the STV0367-NIM-V1.0 NIM card which can be used with the STi
> > > STB SoC's.
> > 
> > Barely associated to this specific patch, but for
> > dvb-pll.c, another thing that seems possible is to
> > convert the struct dvb_pll_desc uses to const and
> > change the "entries" fixed array size from 12 to []
> > 
> > It'd save a couple KB overall and remove ~5KB of data.
> > 
> > $ size drivers/media/dvb-frontends/dvb-pll.o*
> >    text	   data	    bss	    dec	    hex	filename
> >    8520	   1552	   2120	  12192	   2fa0	drivers/media/dvb-frontends/dvb-pll.o.new
> >    5624	   6363	   2120	  14107	   371b	drivers/media/dvb-frontends/dvb-pll.o.old
> 
> Peter,
> 
> Please add this patch on the next patch series you submit.

Ok will do, I've added this patch with a slightly updated commit message
to my series.

Joe - Can I add your signed-off-by?

regards,

Peter.
