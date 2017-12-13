From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 13 Dec 2017 11:42:21 +0100
Subject: [PATCH] arm64: allwinner: a64: a64-olinuxino: add usb otg
In-Reply-To: <CAMty3ZDEhXjHTE4WsJK8=yAayuR=qvJQaZEjGq=LDS6Y4V7RFw@mail.gmail.com>
References: <1513058169-25516-1-git-send-email-jagan@amarulasolutions.com>
 <20171212081335.3qkqcofdbcfuu5zh@flea.lan>
 <CAMty3ZDEhXjHTE4WsJK8=yAayuR=qvJQaZEjGq=LDS6Y4V7RFw@mail.gmail.com>
Message-ID: <20171213104221.zrpwlayahzd7m4fh@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 12, 2017 at 02:57:01PM +0530, Jagan Teki wrote:
> On Tue, Dec 12, 2017 at 1:43 PM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > Hi,
> >
> > On Tue, Dec 12, 2017 at 11:26:09AM +0530, Jagan Teki wrote:
> >> Add usb otg support for a64-olinuxino board,
> >> - USB0-ID connected with PH9
> >> - USB0-VBUSDET connected with PH6
> >> - USB-DRVVBUS controlled by N_VBUSEN pin from PMIC
> >>
> >> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> >
> > How was this tested? Did you test the OTG part, or only the peripheral
> > part?
> 
> Yes peripheral.

Please test the switching between host and peripheral then, and the
same comment applies to your bananapi-m64.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171213/d8867d92/attachment-0001.sig>
