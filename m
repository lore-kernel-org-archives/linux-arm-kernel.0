From: stefan@agner.ch (Stefan Agner)
Date: Thu, 16 Apr 2015 09:56:44 +0200
Subject: [PATCH 1/2] Documentation: devicetree: root node serial-number
 property documentation
In-Reply-To: <1427564371-26039-1-git-send-email-contact@paulk.fr>
References: <1427564371-26039-1-git-send-email-contact@paulk.fr>
Message-ID: <f6f4f862c78fa626e7f94bde51eec5b1@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015-03-28 18:39, Paul Kocialkowski wrote:
> Signed-off-by: Paul Kocialkowski <contact@paulk.fr>

I think this is a worthwhile standardization.

Acked-by: Stefan Agner <stefan@agner.ch>


> ---
>  Documentation/devicetree/booting-without-of.txt | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/booting-without-of.txt
> b/Documentation/devicetree/booting-without-of.txt
> index 7768518..8b055897 100644
> --- a/Documentation/devicetree/booting-without-of.txt
> +++ b/Documentation/devicetree/booting-without-of.txt
> @@ -828,6 +828,10 @@ address which can extend beyond that limit.
>    name may clash with standard defined ones, you prefix them with your
>    vendor name and a comma.
>  
> +  Additional properties for the root node:
> +
> +    - serial-number : a string representing the board's serial number
> +
>    b) The /cpus node
>  
>    This node is the parent of all individual CPU nodes. It doesn't
