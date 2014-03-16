From: dmitry.torokhov@gmail.com (Dmitry Torokhov)
Date: Sun, 16 Mar 2014 12:26:01 -0700
Subject: [PATCH 14/15] Input: atmel_tsadcc: remove driver
In-Reply-To: <5325ECE3.5090800@kernel.org>
References: <1394040940-18246-1-git-send-email-alexandre.belloni@free-electrons.com>
 <20140305184611.GA5453@core.coreip.homeip.net> <5325ECE3.5090800@kernel.org>
Message-ID: <5652100.Y5W0uRRy4s@dtor-d630.eng.vmware.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday, March 16, 2014 06:26:43 PM Jonathan Cameron wrote:
> On 05/03/14 18:46, Dmitry Torokhov wrote:
> > On Wed, Mar 05, 2014 at 06:35:39PM +0100, Alexandre Belloni wrote:
> >> The atmel_tsadcc driver is not used anymore, it has been replaced by
> >> at91_adc so remove it.
> >> 
> >> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> > 
> > Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> 
> All the rest of this series looks fine to me.
> 
> Dmitry, are you happy for me to take this whole series through IIO once
> the last few bits are pinned down?  If the atmel guys want to take the whole
> thing through their tree I'm also happy with that.
> 
> Not sure what the lowest pain route will be...

Jonathan,

I am fine with either one of these 2 options.

Thanks.

-- 
Dmitry
