From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 25 Jul 2013 18:06:51 -0300
Subject: Enabling USBH1 on mx53qsb
In-Reply-To: <CAOMZO5CYNAKPFL1LgNGzwyZe9aCP9NHEXJFx+ymiqQf=QVx9YQ@mail.gmail.com>
References: <CAOMZO5CAdxzn-3Xc2DZDYEXwsEznRrcqPbCbTDc5ieBkQkA8=g@mail.gmail.com>
 <8738r2wxcx.fsf@lebrac.rtp-net.org>
 <CAOMZO5CYNAKPFL1LgNGzwyZe9aCP9NHEXJFx+ymiqQf=QVx9YQ@mail.gmail.com>
Message-ID: <CAOMZO5CYnj1nNYMe4aONFCQ+a3pgtiAxSWWP+h5XvOjLO308Bg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 25, 2013 at 5:26 PM, Fabio Estevam <festevam@gmail.com> wrote:

> So we have a bug in the chipidea driver not writing to USBH1 PORTSC
> register even if I pass the "phy_type" via dt.

I fixed the issue and will submit the patches shortly.
