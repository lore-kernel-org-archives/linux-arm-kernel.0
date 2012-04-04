From: shijie8@gmail.com (Huang Shijie)
Date: Wed, 4 Apr 2012 07:19:20 -0400
Subject: [PATCH] mtd/gpmi : do not include the mxs.h
In-Reply-To: <20120404075748.GA9073@pengutronix.de>
References: <1333247817-18472-1-git-send-email-shijie8@gmail.com>
 <20120403193920.GC2201@pengutronix.de>
 <CAMiH66FhFFi1Kd7t6uK4S46Yt=g1kxxCUZywCNAmy14E1AHH1A@mail.gmail.com>
 <20120404075748.GA9073@pengutronix.de>
Message-ID: <CAMiH66EPYQiiSOtnt=e9RpcrWKOUoH6=H5B0uJw14hZaHMLjEQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 4, 2012 at 3:57 AM, Wolfram Sang <w.sang@pengutronix.de> wrote:
> Hi,
>
>> Do you mean your patch "lib: add support for stmp-style devices" ?
>> or some other patch?
>
> Yes, it adds the SET and CLR macros. writel() then need to be modified again.
> Nothing major, though.

The two macros are not needed if you give me a two arguments API such
as gpmi_reset_block().
I wish I can remove the gpmi_reset_block(), and use your code. :)

>
>> Your patch "lib: add support for stmp-style devices" does not give me the API
>> to remove this code as i ever wished to.
>
> Then please speak up. The only comment I can find from you is the requested
> move to a fsl-directory, but this is nothing about API?
yes.
I will send new comments about your patch.


 thanks.

Huang Shijie

>
> Regards,
>
> ? Wolfram
>
> --
> Pengutronix e.K. ? ? ? ? ? ? ? ? ? ? ? ? ? | Wolfram Sang ? ? ? ? ? ? ? ?|
> Industrial Linux Solutions ? ? ? ? ? ? ? ? | http://www.pengutronix.de/ ?|
