From: lkundrak@v3.sk (Lubomir Rintel)
Date: Wed, 10 Oct 2018 19:26:56 +0200
Subject: [PATCH 3/5] spi: pxa2xx: use an enum for type
In-Reply-To: <87d0t64mkk.fsf@belgarion.home>
References: <20180910115935.163121-1-lkundrak@v3.sk>
 <20180910115935.163121-4-lkundrak@v3.sk> <87d0t64mkk.fsf@belgarion.home>
Message-ID: <817b05ed7a619e9c46594f395ebc02d7cde9fc24.camel@v3.sk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2018-09-21 at 22:34 +0200, Robert Jarzmik wrote:
> Lubomir Rintel <lkundrak@v3.sk> writes:
> 
> > That seems to be the correct type.
> Okay, but what happens here when adev_id->driver_data is a value out
> of enum
> range ? Does the following assignment make sense ?
> > +		type = (enum pxa_ssp_type)adev_id->driver_data;
> 
> As a side note, could you join for the next throw to the review :
>  - Jarkko Nikula <jarkko.nikula@linux.intel.com>
>  - Mika Westerberg <mika.westerberg@linux.intel.com>

Argh, of course I forgot. My apologies.

Jarkko & Mika, I'm wondering if you could take a look at the [1] thread
and tell me what you think. (I can forward it to you via e-mail too, if
you're not subscribed to lists it has been Cc'd to, if that would be
more convenient).

[1] [PATCH 0/11] spi: pxa2xx: add DT and slave mode support"
    https://lore.kernel.org/lkml/20181010170936.316862-1-lkundrak at v3.sk/T/#t

Thanks
Lubo

> 
> Even if they are Intel, I think they have worked a lot on this driver
> for Intel
> platforms.
> 
> Cheers.
> 
