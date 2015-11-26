From: ivo.g.dimitrov.75@gmail.com (Ivaylo Dimitrov)
Date: Thu, 26 Nov 2015 23:12:38 +0200
Subject: [PATCH 5/5] arm: boot: store ATAGs structure into DT
 "/chosen/linux,atags" entry
In-Reply-To: <20151126203930.GW2517@atomide.com>
References: <20150713131902.GH26485@atomide.com> <20151123144545.GD24147@pali>
 <20151125181644.GI2517@atomide.com> <17134653.86P3dFyQKK@wuerfel>
 <20151125210310.GT2517@atomide.com> <56568849.5080103@gmail.com>
 <20151126090739.GD14190@pali> <20151126203930.GW2517@atomide.com>
Message-ID: <565775C6.8070500@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 26.11.2015 22:39, Tony Lindgren wrote:

> Just to explore options.. How about make a minimal device driver that
> just loads the atags blob from /lib/firmware and then shows it in
> /proc/atags? Of course some checking on the atags should be done by
> the driver..
>

What is the chance for such a driver to be accepted upstream? As IIRC 
the current situation is because similar driver was rejected. Might be 
wrong as well, it was about 2-3 years ago.

Regards,
Ivo
