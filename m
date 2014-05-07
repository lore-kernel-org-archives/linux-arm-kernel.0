From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 7 May 2014 17:03:17 -0500
Subject: [PATCH 5/7] usb: ohci-platform: Enable optional use of reset
 controller
In-Reply-To: <536A5EBF.10309@cogentembedded.com>
References: <1399434623-20383-1-git-send-email-maxime.ripard@free-electrons.com>
 <1399434623-20383-6-git-send-email-maxime.ripard@free-electrons.com>
 <536A5EBF.10309@cogentembedded.com>
Message-ID: <20140507220317.GD7047@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 07, 2014 at 08:26:39PM +0400, Sergei Shtylyov wrote:
> Hello.
> 
> On 07-05-2014 7:50, Maxime Ripard wrote:
> 
> >The OHCI controllers used in the Allwinner A31 are asserted in reset using a
> 
>    s/asserted/powered up/?

No. There's an external reset controller that maintains these devices
into reset. It's not only a power on thing, it can also be put back
into reset later in the life of the system.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140507/1cc9568f/attachment.sig>
