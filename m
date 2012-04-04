From: shijie8@gmail.com (Huang Shijie)
Date: Wed, 4 Apr 2012 03:26:41 -0400
Subject: [PATCH] mtd/gpmi : do not include the mxs.h
In-Reply-To: <20120403193920.GC2201@pengutronix.de>
References: <1333247817-18472-1-git-send-email-shijie8@gmail.com>
 <20120403193920.GC2201@pengutronix.de>
Message-ID: <CAMiH66FhFFi1Kd7t6uK4S46Yt=g1kxxCUZywCNAmy14E1AHH1A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wolfram:

On Tue, Apr 3, 2012 at 3:39 PM, Wolfram Sang <w.sang@pengutronix.de> wrote:
> On Sat, Mar 31, 2012 at 10:36:57PM -0400, Huang Shijie wrote:
>> The mxs.h does not exit in the mx6q.
>> So rewrite the __mxs_clrl()/__mxs_setl() and remove the mxs.h.
>>
>> Signed-off-by: Huang Shijie <shijie8@gmail.com>
>
> I am quite sure we will have STMP devices in 3.5 which should make this patch
Do you mean your patch "lib: add support for stmp-style devices" ?
or some other patch?


Your patch "lib: add support for stmp-style devices" does not give me
the API to remove this
code as i ever wished to.


BR
Huang Shijie



> obsolete. If this patch is considered a bugfix for 3.4, then OK for now.
>
> Regards,
>
> ? Wolfram
>
> --
> Pengutronix e.K. ? ? ? ? ? ? ? ? ? ? ? ? ? | Wolfram Sang ? ? ? ? ? ? ? ?|
> Industrial Linux Solutions ? ? ? ? ? ? ? ? | http://www.pengutronix.de/ ?|
