From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Fri, 9 May 2014 12:34:03 +0300
Subject: [PATCH 0/4] OMAPDSS: Add support for panel ls037v7dw01
In-Reply-To: <20140505184138.GB15463@atomide.com>
References: <1398815562-24113-1-git-send-email-tony@atomide.com>
 <20140505184138.GB15463@atomide.com>
Message-ID: <536CA10B.9040702@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/05/14 21:41, Tony Lindgren wrote:
> * Tony Lindgren <tony@atomide.com> [140429 16:53]:
>> Hi all,
>>
>> Here are few patches to add devicetree support for panel ls037v7dw01
>> that's found on many omap3 boards. They seem to be often mis-configured
>> as various panel dpi entries, but really should be move to use panel
>> ls037v7dw01 instead. This panel is found at least on the omap3 sdp,
>> ldp, omap3 evm and few other development boards.
> 
> Tomi, assuming no more comments, do you want to pick up the first
> three patches of this series? I can queue the .dts changes or you
> can also set up a separate .dts changes branch for DSS that I can
> merge in too.

If it's all the same to you, I'd like to collect all display related
arch/arm/ patches into my tree, and I'll send you a merge request when
it's stable.

I already have OMAP5 and AM43xx stuff there.

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140509/935f4200/attachment.sig>
