From: eric@eukrea.com (=?UTF-8?B?RXJpYyBCw6luYXJk?=)
Date: Thu, 15 Dec 2011 07:55:53 +0100
Subject: [PATCH 16/19] eukrea-cpuimx51: remove board
In-Reply-To: <20111215035854.GA24039@avalanche>
References: <1323757911-25217-1-git-send-email-eric@eukrea.com>
 <1323757911-25217-16-git-send-email-eric@eukrea.com>
 <20111213100532.GH27267@pengutronix.de> <4EE7253E.2030604@eukrea.com>
 <20111215035854.GA24039@avalanche>
Message-ID: <4EE999F9.7000804@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Amit,

Le 15/12/2011 04:58, Amit Kucheria a ?crit :
 > On 11 Dec 13, Eric B?nard wrote:
 >> Hi Sascha,
 >>
 >> Le 13/12/2011 11:05, Sascha Hauer a ?crit :
 >>> On Tue, Dec 13, 2011 at 07:31:48AM +0100, Eric B?nard wrote:
 >>>> this board is not maintained anymore and is replaced by cpuimx51sd
 >>>
 >>> I'm happy to remove this code, but aren't there any users of this board?
 >>>
 >> not any that would need a kernel upgrade considering the Freescale
 >> proprietary drivers used on it :-(
 >> Thanks,
 >> Eric
 >
 > Just for posterity, could you list the drivers that make an upgrade
 > impossible?
 >
at least gpu (AMD/FSL proprietary) & iirc video codecs (not all proprietary 
but far from mainline unless I missed something). In fact in the end these 
boards were using Freescale's kernel.

 > IMHO, if these boards were sold commercially we should maintain support if
 > there is a chance that we will get open drivers in the future.
 >
 > OTOH, if you can tell who each of these boards to, it is probably a good
 > target for removal. :)
 >
I confirm that's a good target for removal as our i.MX51 customers are 
actually using cpuimx51sd (actually without 3D & codecs actually but not 
everyone need these peripherals in industrial applications). Moreover, if all 
the drivers are mainlined we will be able to use dt if we want to upgrade 
cpuimx51.

Thanks,
Eric
