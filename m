From: b.galvani@gmail.com (Beniamino Galvani)
Date: Tue, 11 Nov 2014 12:18:39 +0100
Subject: [PATCH v2 2/3] media: rc: add driver for Amlogic Meson IR remote
 receiver
In-Reply-To: <20141109203608.GA837@gofer.mess.org>
References: <1415521928-25251-1-git-send-email-b.galvani@gmail.com>
 <1415521928-25251-3-git-send-email-b.galvani@gmail.com>
 <20141109203608.GA837@gofer.mess.org>
Message-ID: <20141111111839.GA17620@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 09, 2014 at 08:36:09PM +0000, Sean Young wrote:
> > [...]
> > +	dev_info(dev, "receiver initialized\n");
> > +
> > +	return 0;
> > +out_unreg:
> > +	rc_unregister_device(ir->rc);
> 
> rc_unregister_device() already calls rc_free_device().

Right, I will fix this.

Thanks,
Beniamino
