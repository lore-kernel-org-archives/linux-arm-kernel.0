From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Mon, 9 Mar 2015 17:11:57 +0100
Subject: [RFC V2 03/12] i2c: at91: make use of the new infrastructure for
 quirks
In-Reply-To: <20150308082845.GB1904@katana>
References: <1424880126-15047-1-git-send-email-wsa@the-dreams.de>
 <1424880126-15047-4-git-send-email-wsa@the-dreams.de>
 <20150308082845.GB1904@katana>
Message-ID: <20150309161157.GW9132@odux.rfo.atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wolfram,

On Sun, Mar 08, 2015 at 09:28:45AM +0100, Wolfram Sang wrote:
> On Wed, Feb 25, 2015 at 05:01:54PM +0100, Wolfram Sang wrote:
> > From: Wolfram Sang <wsa+renesas@sang-engineering.com>
> > 
> > Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> 
> Hi Ludovic,
> 
> if you have a few minutes, could you please test this series? I'd like to
> include it in 4.1. and because at91 is using the quirk infrastructure in
> a more complex way, it is a really good test candidate.

It was in the pipe. I have reviewed it, this second version seems to be
good. I am just waiting a bit more to give you my ack since I have some
issues to read an i2c eeprom (it works with a temperature sensor).
I am investigating if it doesn't come from a previous regression.

> 
> Thanks,
> 
>    Wolfram
> 

Regards

Ludovic
