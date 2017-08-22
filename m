From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Tue, 22 Aug 2017 15:23:39 +0300
Subject: [PATCH v2] ARM: dts: r8a7743: add IIC cores to dtsi
In-Reply-To: <TY1PR06MB07027D9A55FBFE2D591CEDCFB7840@TY1PR06MB0702.apcprd06.prod.outlook.com>
References: <12d923ba-184c-ef59-f27b-41a7592a5f93@cogentembedded.com>
 <1502704398-28378-1-git-send-email-biju.das@bp.renesas.com>
 <TY1PR06MB07027D9A55FBFE2D591CEDCFB7840@TY1PR06MB0702.apcprd06.prod.outlook.com>
Message-ID: <b7434757-b151-5971-2b5f-525eeaf11467@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/22/2017 12:10 PM, Chris Paterson wrote:

>> From: Biju Das [mailto:biju.das at bp.renesas.com]
>> Sent: 14 August 2017 10:53
>>
>> Signed-off-by: Biju Das <biju.das@bp.renesas.com>
>> ---
>> v1-->v2
>>     Corrected the resets property for i2c6 device node.
> 
> Are you happy with this version of the patch?
> 
> Or is the discussion for moving to 'iic' still alive?

    Yes, appears so. I'd like the labels to be named iic<n>.

> Thanks, Chris

MBR, Sergei
