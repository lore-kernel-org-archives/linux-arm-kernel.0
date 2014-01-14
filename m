From: balbi@ti.com (Felipe Balbi)
Date: Tue, 14 Jan 2014 07:12:23 -0600
Subject: [PATCHv4 0/7] omap hwspinlock dt support
In-Reply-To: <1389658764-39199-1-git-send-email-s-anna@ti.com>
References: <1389658764-39199-1-git-send-email-s-anna@ti.com>
Message-ID: <20140114131223.GC10818@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 13, 2014 at 06:19:17PM -0600, Suman Anna wrote:
> This is an updated series mainly addressing Mark Rutland's comments
> about hwlock specifier being always one-cell. The series adds the
> support for #hwlock-cells property and adds a simple default OF
> translate function.
> 
> The DTS patches from previous series have already been merged, and
> needs this property to be added. This is handled in a separate series
> that only deals with OMAP hwspinlock DTS patches.
> 
> The series, along with the DTS patches, is tested on top of v3.13-rc8
> plus Tero's v13 clock DT series and Tony's 3.14 staged branches. The
> validation on OMAP5, DRA7, AM437 requires Tero's series with couple of
> additional base patches for AM43xx. AM43xx functionality needs a hwmod
> fix [1] for creating the associated omap_device as well.
> 
> The validation logs on all the applicable OMAP SoCs are at:
>   OMAP4 - http://paste2.org/YJ7ZwG80
>   OMAP5 - http://paste2.org/c6vO96b9
>   DRA7  - http://paste2.org/tHvxN439
>   AM33x - http://paste2.org/AjCv0U4t
>   AM43x - http://paste2.org/2AKIPa55

I build tested your 3.13-rc8-v4 branch with the same script I used to
build CCF series and hspinlock built without any problems ;-)

Acked-by: Felipe Balbi <balbi@ti.com>

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140114/77e31aff/attachment.sig>
