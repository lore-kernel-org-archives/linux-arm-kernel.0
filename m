From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Wed, 28 Feb 2018 10:38:40 +0300
Subject: [PATCH 2/4] dt-bindings: arm: Document Renesas V3MSK and Wheat
 board part numbers
In-Reply-To: <20180228064911.vnax4vyqnq6lry52@verge.net.au>
References: <20180228064911.vnax4vyqnq6lry52@verge.net.au>
Message-ID: <4a2ae4c8-4a4b-1ea3-3416-2dfdffee6499@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2/28/2018 9:49 AM, Simon Horman wrote:

[...]

>> On Tue, Feb 27, 2018 at 9:17 AM, Simon Horman <horms@verge.net.au> wrote:
>>> On Mon, Feb 26, 2018 at 07:03:43PM +0100, Geert Uytterhoeven wrote:
> 
> ...
> 
>>>> -  - Wheat
>>>> +  - Wheat (RTP0RC7792ASKB0010JE)
>>>>       compatible = "renesas,wheat", "renesas,r8a7792"
>>>
>>> I'm unable to confirm the above. Can anyone help?
>>
>> https://elinux.org/R-Car/Boards/Wheat
>>
>> Looks like I misinterpreted the pictures, and
>> RTP0RC7792ASKB0000JE is the correct part number for Wheat.
> 
> Thanks. I've applied the following.
> 
> 
> From: Geert Uytterhoeven <geert+renesas@glider.be>
> Subject: [PATCH] dt-bindings: arm: Document Renesas V3MSK and Wheat board part
>   numbers
> 
> The DT binding documentation for the Renesas V3MSK and Wheat boards
> lacked board part numbers.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> [simon: corrected Wheat part number]
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> ---
>   Documentation/devicetree/bindings/arm/shmobile.txt | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/shmobile.txt b/Documentation/devicetree/bindings/arm/shmobile.txt
> index a99359e63b0a..66edc1406bb8 100644
> --- a/Documentation/devicetree/bindings/arm/shmobile.txt
> +++ b/Documentation/devicetree/bindings/arm/shmobile.txt
> @@ -120,9 +120,9 @@ Boards:
>       compatible = "renesas,sk-rzg1m", "renesas,r8a7743"
>     - Stout (ADAS Starterkit, Y-R-CAR-ADAS-SKH2-BOARD)
>       compatible = "renesas,stout", "renesas,r8a7790"
> -  - V3MSK
> +  - V3MSK (Y-ASK-RCAR-V3M-WS10)

    https://elinux.org/R-Car/Boards/V3MSK (now that I'm reminded of this site) 
says the V3MSK's model # is RTP0RC77970SEB0010S.

>       compatible = "renesas,v3msk", "renesas,r8a77970"
> -  - Wheat
> +  - Wheat (RTP0RC7792ASKB0000JE)
>       compatible = "renesas,wheat", "renesas,r8a7792"

MBR, Sergei
