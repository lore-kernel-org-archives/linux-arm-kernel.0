From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Thu, 08 May 2014 17:11:07 +0400
Subject: [PATCH 5/7] usb: ohci-platform: Enable optional use of reset
 controller
In-Reply-To: <20140507220317.GD7047@lukather>
References: <1399434623-20383-1-git-send-email-maxime.ripard@free-electrons.com>
 <1399434623-20383-6-git-send-email-maxime.ripard@free-electrons.com>
 <536A5EBF.10309@cogentembedded.com> <20140507220317.GD7047@lukather>
Message-ID: <536B826B.7010908@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 05/08/2014 02:03 AM, Maxime Ripard wrote:

>>> The OHCI controllers used in the Allwinner A31 are asserted in reset using a

>>     s/asserted/powered up/?

> No. There's an external reset controller that maintains these devices
> into reset. It's not only a power on thing, it can also be put back
> into reset later in the life of the system.

    However, the expression that "the OHCI controllers are asserted in reset" 
still seems dubious to me...

> Maxime

WBR, Sergei
