From: nm@ti.com (Nishanth Menon)
Date: Thu, 1 Aug 2013 11:10:55 -0500
Subject: [PATCHv4 09/33] CLK: omap: add omap4 clock init file
In-Reply-To: <51FA7FFB.8000309@ti.com>
References: <1374564028-11352-1-git-send-email-t-kristo@ti.com>
 <1374564028-11352-10-git-send-email-t-kristo@ti.com>
 <51F81516.3050302@ti.com> <51F924CA.6000803@ti.com>
 <51FA7341.7040303@ti.com> <51FA7FFB.8000309@ti.com>
Message-ID: <CAGo_u6qze7SaCdTrqhby0guKu03DcRVchkV-qmT4uz2PgJMYHQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 1, 2013 at 10:34 AM, Tero Kristo <t-kristo@ti.com> wrote:
>>
>> I think you already dealt with (c). in the same vein, we can do (a) and
>> (b). Dont think anyone else has gone about this to the extent we are
>> attempting to do till date, so as pioneers, we might as well suggest
>> with a patch :D ?
>
>
> Yea, for c I have a patch as that is clearly required. For a/b, we can
> currently workaround. Again, I don't want to implement everything in this
> set at once, as the result would be a huge behemoth (this is complicated
> enough as is imo.)
this series will be smaller if you do it, not larger. you would just
need to introduce those parameters and not have to deal with SoC
specific "hacky drivers".
Regards,
NM
