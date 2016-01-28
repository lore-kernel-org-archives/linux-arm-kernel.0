From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 28 Jan 2016 18:31:16 +0100
Subject: [linux-sunxi] Problem with Allwinner H3 clocks
In-Reply-To: <56A9CE3D.4020906@redhat.com>
References: <20160127084607.665fb8c38eeb5733ce4232da@free.fr>
 <CAGb2v65FUhNC-d-YT=-2adNHHT6b1JvGoNTFLfBX_xBSnuOsTg@mail.gmail.com>
 <20160127103714.58312b152adb4148bae2f93b@free.fr>
 <56A8D5E5.30701@gmail.com>
 <20160127175512.87caf31b5e21a1fec91507f2@free.fr>
 <56A9098A.5010107@redhat.com>
 <20160127200217.14dce96ade71cf81bc82e6f6@free.fr>
 <56A9CE3D.4020906@redhat.com>
Message-ID: <20160128173116.GA32462@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 28, 2016 at 09:15:57AM +0100, Hans de Goede wrote:
> Hi,
> 
> On 27-01-16 20:02, Jean-Francois Moine wrote:
> >On Wed, 27 Jan 2016 19:16:42 +0100
> >Hans de Goede <hdegoede@redhat.com> wrote:
> >
> >>>To be sure, I generated a pure 4.5-rc1 kernel. Same result: no UART.
> >>>Maybe... one more information: I am using Allwinner's u-boot.
> >>
> >>Could be that that is the culprit, why are you not using upstream u-boot?
> >>upstream u-boot has H3 and orangepi-pc support now.
> >
> >Yes, but using the upstream u-boot may hide the clock problem.
> 
> I agree that that could be the case. Would be interesting to figure out
> what exactly is needed to get the upstream kernel to work properly
> with allwinner's u-boot.

I'm guessing it's probably because of the arch timers that have not
been properly initialized.

Do you have any earlyprintk output?

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160128/b34d32da/attachment-0001.sig>
