From: csd@broadcom.com (Christian Daudt)
Date: Tue, 14 May 2013 08:01:51 -0700
Subject: [PATCH] ARM: mach-bcm: drop "select GPIO_BCM"
In-Reply-To: <1368543520.1350.105.camel@x61.thuisdomein>
References: <1368524085.1350.102.camel@x61.thuisdomein>
 <51924FE4.5000803@broadcom.com>
 <1368543520.1350.105.camel@x61.thuisdomein>
Message-ID: <519251DF.4070809@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13-05-14 07:58 AM, Paul Bolle wrote:
> On Tue, 2013-05-14 at 07:53 -0700, Christian Daudt wrote:
>> We are planning on submitting the driver for this option for review
>> over the next couple of weeks, to get it in the 3.11 cycle. So this
>> patch won't be necessary.
> I see. Did my web searches miss something or will that be the first time
> you submit that driver for review?
Your web searches are correct. The driver was not ready for review at 
the time the initial SoC support was originally submitted, so the config 
should have been removed. It leaked out :)

  thanks,
    csd
