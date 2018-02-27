From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Tue, 27 Feb 2018 13:47:09 +0300
Subject: [PATCH 2/4] dt-bindings: arm: Document Renesas V3MSK and Wheat
 board part numbers
In-Reply-To: <20180227081711.nnd2r35mu3h7rjz5@verge.net.au>
References: <1519668225-12548-1-git-send-email-geert+renesas@glider.be>
 <1519668225-12548-3-git-send-email-geert+renesas@glider.be>
 <20180227081711.nnd2r35mu3h7rjz5@verge.net.au>
Message-ID: <36c4cab2-3e41-d5ed-27a4-5a297887cf10@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello!

On 02/27/2018 11:17 AM, Simon Horman wrote:

>> The DT binding documentation for the Renesas V3MSK and Wheat boards
>> lacked board part numbers.
>>
>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>> ---
>>  Documentation/devicetree/bindings/arm/shmobile.txt | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/arm/shmobile.txt b/Documentation/devicetree/bindings/arm/shmobile.txt
>> index ded2cd3b5f4df0c8..82908a9447e4b051 100644
>> --- a/Documentation/devicetree/bindings/arm/shmobile.txt
>> +++ b/Documentation/devicetree/bindings/arm/shmobile.txt
>> @@ -120,9 +120,9 @@ Boards:
>>      compatible = "renesas,sk-rzg1m", "renesas,r8a7743"
>>    - Stout (ADAS Starterkit, Y-R-CAR-ADAS-SKH2-BOARD)
>>      compatible = "renesas,stout", "renesas,r8a7790"
>> -  - V3MSK
>> +  - V3MSK (Y-ASK-RCAR-V3M-WS10)

   ACK.

>>      compatible = "renesas,v3msk", "renesas,r8a77970"
> 
> Google also tells me there is WS20, but I guess WS10 what is
> currently supported upstream.

   At least that's what I have on my desk. :-)

>> -  - Wheat
>> +  - Wheat (RTP0RC7792ASKB0010JE)
>>      compatible = "renesas,wheat", "renesas,r8a7792"
> 
> I'm unable to confirm the above. Can anyone help?

   Not me -- my documents don't mention this. :-(

MBR, Sergei
