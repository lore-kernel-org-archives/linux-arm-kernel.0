From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 5 Aug 2013 14:50:09 +0100
Subject: [PATCH 2/3] Initial skeleton of VFIO support for Device Tree
 based devices
In-Reply-To: <CAG8rG2yCix04ZHq_rydRVfjfSh15U=LZ38mf_a4ECEUAgvRMbQ@mail.gmail.com>
References: <1375708632-26356-1-git-send-email-a.motakis@virtualopensystems.com>
 <1375708632-26356-3-git-send-email-a.motakis@virtualopensystems.com>
 <20130805133757.GF9910@e106331-lin.cambridge.arm.com>
 <CAG8rG2yCix04ZHq_rydRVfjfSh15U=LZ38mf_a4ECEUAgvRMbQ@mail.gmail.com>
Message-ID: <20130805135009.GG9910@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>      > +static const struct of_device_id vfio_dt_match[] = {
>      > + ? ? /* In the future, we can implement a better mechanism to bind
>      the
>      > + ? ? ?* module to any device. For now add the compatible property to
>      the
>      > + ? ? ?* dtb of the devices we want to use. ? */
>      > + ? ? {
>      > + ? ? ? ? ? ? .compatible = "vfio-dt",
>      > + ? ? },
>      > + ? ? {},
>      > +};
> 
>      This definitely doesn't belong in the dt. It's purely a Linux
>      abstraction and does not represent a piece of hardware or common
>      interface.
> 
>      We need to think of a better mechanism for binding the module to these
>      devices now.
> 
>    I already make this remark in the cover letter; thanks for confirming it.
>    ?
>    Antonios

Sorry, I found the cover letter a little unclear in that regard.

Thanks for the clarification :)

Mark.
