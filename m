From: gregkh@linuxfoundation.org (Greg KH)
Date: Mon, 8 Feb 2016 08:52:26 -0800
Subject: [PATCH v2 04/10] serial: mps2-uart: add MPS2 UART driver
In-Reply-To: <56B87928.7020803@arm.com>
References: <1454413199-26573-1-git-send-email-vladimir.murzin@arm.com>
 <1454413199-26573-5-git-send-email-vladimir.murzin@arm.com>
 <20160207071154.GA32017@kroah.com> <56B87928.7020803@arm.com>
Message-ID: <20160208165226.GA11593@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 08, 2016 at 11:16:56AM +0000, Vladimir Murzin wrote:
> On 07/02/16 07:11, Greg KH wrote:
> >> +
> >> +#define SERIAL_NAME "ttyS"
> > 
> > You can't be "ttyS", there's already a serial port named that, please
> > use a unique name and a new major/minor number (dynamic ideally).
> > 
> 
> Hi Greg,
> 
> I did s/ttyMPS/ttyS per your request for v1 [1]. I'm fine to change it
> back if you prefer that, but I'd be glad to know what I've been missing?
> 
> [1] https://lkml.org/lkml/2015/12/13/8

Yeah, I was wrong, sorry about that, my fault.

greg k-h
