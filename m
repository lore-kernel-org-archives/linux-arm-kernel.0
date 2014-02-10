From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 10 Feb 2014 13:58:32 +0100
Subject: [PATCH 1/7] pinctrl: sh-pfc: r8a7790: Add QSPI pin groups
In-Reply-To: <8438484.DB7cn7tjVR@avalon>
References: <1392029254-15400-1-git-send-email-geert@linux-m68k.org>
 <1392029254-15400-2-git-send-email-geert@linux-m68k.org>
 <8438484.DB7cn7tjVR@avalon>
Message-ID: <CAMuHMdXAhZ0i4NcpymGADfN3wwxRZxpcwRVQEqsqpoGw_O0_Ug@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 10, 2014 at 1:48 PM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>> @@ -4212,6 +4244,7 @@ static const struct sh_pfc_function pinmux_functions[]
>> = { SH_PFC_FUNCTION(msiof0),
>>       SH_PFC_FUNCTION(msiof1),
>>       SH_PFC_FUNCTION(msiof2),
>> +     SH_PFC_FUNCTION(qspi),
>>       SH_PFC_FUNCTION(msiof3),
>
> I believe qspi comes after msiof3 :-)

Doh... silly me...

> Apart from that the patch looks good.
>
> Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
