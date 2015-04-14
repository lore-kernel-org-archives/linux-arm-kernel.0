From: contact@paulk.fr (Paul Kocialkowski)
Date: Tue, 14 Apr 2015 16:31:02 +0200
Subject: [PATCH 1/2] Documentation: devicetree: root node serial-number
 property documentation
In-Reply-To: <1427564371-26039-1-git-send-email-contact@paulk.fr>
References: <1427564371-26039-1-git-send-email-contact@paulk.fr>
Message-ID: <1429021862.2422.16.camel@collins>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le samedi 28 mars 2015 ? 18:39 +0100, Paul Kocialkowski a ?crit :
> Signed-off-by: Paul Kocialkowski <contact@paulk.fr>

Since the merge windows on both U-Boot and Linux are now open, I'd like
to attract your attention on this again.

Any comments/remarks are welcome!

> ---
>  Documentation/devicetree/booting-without-of.txt | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/booting-without-of.txt b/Documentation/devicetree/booting-without-of.txt
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

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150414/031c416d/attachment.sig>
