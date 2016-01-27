From: moinejf@free.fr (Jean-Francois Moine)
Date: Wed, 27 Jan 2016 20:02:17 +0100
Subject: [linux-sunxi] Problem with Allwinner H3 clocks
In-Reply-To: <56A9098A.5010107@redhat.com>
References: <20160127084607.665fb8c38eeb5733ce4232da@free.fr>
 <CAGb2v65FUhNC-d-YT=-2adNHHT6b1JvGoNTFLfBX_xBSnuOsTg@mail.gmail.com>
 <20160127103714.58312b152adb4148bae2f93b@free.fr>
 <56A8D5E5.30701@gmail.com>
 <20160127175512.87caf31b5e21a1fec91507f2@free.fr>
 <56A9098A.5010107@redhat.com>
Message-ID: <20160127200217.14dce96ade71cf81bc82e6f6@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 27 Jan 2016 19:16:42 +0100
Hans de Goede <hdegoede@redhat.com> wrote:

> > To be sure, I generated a pure 4.5-rc1 kernel. Same result: no UART.
> > Maybe... one more information: I am using Allwinner's u-boot.
> 
> Could be that that is the culprit, why are you not using upstream u-boot?
> upstream u-boot has H3 and orangepi-pc support now.

Yes, but using the upstream u-boot may hide the clock problem.

Otherwise, may the upstream u-boot boot the 3.4 kernel from Allwinner?

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
