From: benoit.thebaudeau@advansee.com (=?utf-8?Q?Beno=C3=AEt_Th=C3=A9baudeau?=)
Date: Tue, 12 Jun 2012 23:25:24 +0200 (CEST)
Subject: [PATCH] ARM: mxc-rnga: fix data_present API
In-Reply-To: <CAOMZO5BMWJ4fad+YvJskkRLRiOJn1YRMUnCQ5OWen9SSvTc7Jw@mail.gmail.com>
Message-ID: <1990208746.2534297.1339536324720.JavaMail.root@advansee.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 12, 2012 at 11:12 PM, Fabio Estevam <festevam@gmail.com> wrote:
> On Tue, Jun 12, 2012 at 6:07 PM, Beno?t Th?baudeau
> <benoit.thebaudeau@advansee.com> wrote:
> > +
> > + ? ? ? for (i = 0; i < 20; i++) {
> 
> Where does this magic 20 comes from?

>From the other hw_random drivers. Most use this value, and it works fine on i.MX
too.

Regards,
Beno?t
