From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Sun, 15 Jul 2018 10:12:10 +0200
Subject: [SPAM]Re: [PATCH v5 2/7] serdev: add dev_pm_domain_attach|detach()
In-Reply-To: <1531632595.26214.31.camel@mtkswgap22>
References: <cover.1531150733.git.sean.wang@mediatek.com>
 <d5904115ff1da38fe79b45fa3d59ef0688cea124.1531150733.git.sean.wang@mediatek.com>
 <ED7E5A98-81DC-41B9-9B9A-3EF4EBBED854@holtmann.org>
 <1531632595.26214.31.camel@mtkswgap22>
Message-ID: <20180715081210.GB20758@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jul 15, 2018 at 01:29:55PM +0800, Sean Wang wrote:
> On Sat, 2018-07-14 at 18:27 +0200, Marcel Holtmann wrote:
> > Hi Sean,
> > 
> > > In order to open up the required power gate before any operation can be
> > > effectively performed over the serial bus between CPU and serdev, it's
> > > clearly essential to add common attach functions for PM domains to serdev
> > > at the probe phase.
> > > 
> > > Similarly, the relevant dettach function for the PM domains should be
> > > properly and reversely added at the remove phase.
> > > 
> > > Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> > > Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> > > Cc: Rob Herring <robh@kernel.org>
> > > Cc: Ulf Hansson <ulf.hansson@linaro.org>
> > > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > Cc: Jiri Slaby <jslaby@suse.com>
> > > Cc: linux-serial at vger.kernel.org
> > > ---
> > > drivers/tty/serdev/core.c | 15 ++++++++++++++-
> > > 1 file changed, 14 insertions(+), 1 deletion(-)
> > 
> > can we take this through the serial subsystem? Or should I just take it when the driver is ready to be included?
> > 
> > Regards
> > 
> > Marcel
> > 
> 
> I think it's better if the change is taken through serial subsystem
> first.
> 
> Hi, Rob
> 
> do you have any comment? 

Yeah, I've been ignoring it to wait to get an ack from someone...

greg k-h
