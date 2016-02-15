From: dirk.behme@de.bosch.com (Dirk Behme)
Date: Mon, 15 Feb 2016 13:40:18 +0100
Subject: [PATCH] arm64: dts: r8a7795: Add GIC-400 virtual interfaces
In-Reply-To: <87povyh6lq.wl%kuninori.morimoto.gx@renesas.com>
References: <1455005692-9382-1-git-send-email-dirk.behme@de.bosch.com>
 <87povyh6lq.wl%kuninori.morimoto.gx@renesas.com>
Message-ID: <56C1C732.4050505@de.bosch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15.02.2016 06:46, Kuninori Morimoto wrote:
>
> Hi Dirk
> Cc Geert
>
>> Besides the distributor and the CPU interface the GIC-400 additionally
>> supports the virtual interface control blocks and the virtual CPU interfaces.
>>
>> Add the physical base addresses and size for these.
>>
>> See
>>
>> http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.ddi0471b/index.html
>> -> 3.2. GIC-400 register map
>>
>> and Linux kernel's
>>
>> Documentation/devicetree/bindings/interrupt-controller/arm,gic.txt
>>
>> for more details.
>>
>> Signed-off-by: Dirk Behme <dirk.behme@de.bosch.com>
>> ---
>
> Our R-Car chip is out-of-mapping.
> Geert had indicated it in
> http://thread.gmane.org/gmane.linux.ports.sh.devel/49751/focus=51544
> And we have no answer about it I think


Could you point us to the code where you think our out-of-mapping 
doesn't work?

Best regards

Dirk
