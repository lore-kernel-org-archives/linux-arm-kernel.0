From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Thu, 15 Feb 2018 11:51:58 +0300
Subject: [PATCH v2 2/2] arm64: dts: renesas: eagle: specify EtherAVB PHY
 IRQ
In-Reply-To: <CAMuHMdX3XZSwvAT74fVhWw9GoxVmpdXoqR03=u0QC3FEB==X=w@mail.gmail.com>
References: <038a791d-aa57-9c3d-eaea-09c5704ecb54@cogentembedded.com>
 <0ccd631e-691a-2b15-7680-6e0c847a6ca2@cogentembedded.com>
 <CAMuHMdX3XZSwvAT74fVhWw9GoxVmpdXoqR03=u0QC3FEB==X=w@mail.gmail.com>
Message-ID: <9003179f-379d-0576-37bf-1b08700ebd41@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello!

On 2/14/2018 1:02 PM, Geert Uytterhoeven wrote:

>> Specify  EtherAVB PHY IRQ  in the Eagle board's device tree, now that we
>> have the GPIO support (previously phylib had to resort to polling).
>>
>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> 
> You've dropped my:
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

    Sorry, I was too hasty to resubmit. :-/

> Gr{oetje,eeting}s,
> 
>                          Geert

MBR, Sergei
