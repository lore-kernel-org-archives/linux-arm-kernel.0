From: balbi@ti.com (Felipe Balbi)
Date: Tue, 27 Aug 2013 13:37:32 -0500
Subject: linux-next: manual merge of the arm-soc tree with the usb tree
In-Reply-To: <20130827173732.GC21564@kroah.com>
References: <20130827181353.319c150858829df1bb68d60b@canb.auug.org.au>
 <521C6961.9020103@linutronix.de>
 <CABxcv=mg6t5wPqpF3j5sr_76qfZ7N7KgpWhcKSGoPTOcaR=V6A@mail.gmail.com>
 <521CA888.1080909@baylibre.com> <521CAF59.1090203@linutronix.de>
 <521CB046.9070408@baylibre.com> <521CB18B.4080000@linutronix.de>
 <521CB239.6050409@baylibre.com> <521CB403.8010307@linutronix.de>
 <20130827173732.GC21564@kroah.com>
Message-ID: <20130827183732.GP3005@radagast>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Aug 27, 2013 at 10:37:32AM -0700, Greg KH wrote:
> On Tue, Aug 27, 2013 at 04:13:23PM +0200, Sebastian Andrzej Siewior wrote:
> > On 08/27/2013 04:05 PM, Benoit Cousson wrote:
> > > On 27/08/2013 16:02, Sebastian Andrzej Siewior wrote:
> > >> On 08/27/2013 03:57 PM, Benoit Cousson wrote:
> > >>> + Kevin,
> > >>>
> > >>> On 27/08/2013 15:53, Sebastian Andrzej Siewior wrote:
> > >>>> What do we do now?
> > >>>
> > >>> Cannot you just merge the stable arm-soc/dt branch into your branch
> > >>> before applying your patches?
> > >>
> > >> That is up to Greg. This changes sat in his usb-next tree for a while
> > >> now. And before they hit Greg they were in Felipe's tree for a while.
> > >>
> > >> To be exact, last .dts change via USB was:
> > >>
> > >> Author:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > >> AuthorDate: Thu Jun 20 12:13:04 2013 +0200
> > >> Commit:     Felipe Balbi <balbi@ti.com>
> > >> CommitDate: Fri Aug 9 17:40:16 2013 +0300
> > >>
> > >>     usb: musb dma: add cppi41 dma driver
> > > 
> > > Mmm, if that branch is supposed to be stable, I'm not sure it will be
> > > doable...
> > > 
> > > Maybe we should do the other way around? And merge usb-next into
> > > arm-soc/dt.
> > > 
> > > Kevin, Olof?
> > 
> > Please be aware that I have no response so far regarding [0] from Greg.
> > 
> > [0] http://www.spinics.net/lists/linux-usb/msg92595.html
> 
> Nor will you, given that I am not the one to take these patches, Felipe
> is.  I noticed now that you said "please route around Felipe", but
> sorry, no, I'm not going to do that unless there's a really good reason.
> Felipe seems to be around at the moment, please work with him on this.

If you will still take a 'part2' pull request from me, I can send you
urgent bugfixes by friday. If I have some time left, I can even try to
get that sorted out by tomorrow.

cheers

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130827/266a1741/attachment.sig>
