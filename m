From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Wed, 30 Jul 2014 15:09:42 +0300
Subject: [PATCH v2] ARM: AM43xx: hwmod: add DSS hwmod data
In-Reply-To: <alpine.DEB.2.02.1407222110260.25593@utopia.booyaka.com>
References: <1402994233-22599-1-git-send-email-tomi.valkeinen@ti.com>
 <alpine.DEB.2.02.1407222110260.25593@utopia.booyaka.com>
Message-ID: <53D8E086.9070206@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23/07/14 00:14, Paul Walmsley wrote:
> On Tue, 17 Jun 2014, Tomi Valkeinen wrote:
> 
>> From: Sathya Prakash M R <sathyap@ti.com>
>>
>> Add DSS hwmod data for AM43xx.
>>
>> Signed-off-by: Sathya Prakash M R <sathyap@ti.com>
>> [tomi.valkeinen at ti.com: added missing dispc flags]
>> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
>> Acked-by: Rajendra Nayak <rnayak@ti.com>
> 
> This one didn't compile on an AM43xx-only build:
> 
> ----
> arch/arm/mach-omap2/built-in.o:(.data+0x3f2c): undefined reference to `omap2_dss_hwmod_class'
> arch/arm/mach-omap2/built-in.o:(.data+0x405c): undefined reference to `omap2_rfbi_hwmod_class'
> make: *** [vmlinux] Error 1
> test_build: Tue Jul 22 13:48:50 MDT 2014: FAILED on omap2plus_defconfig_am43xx_only hwmod-a-v3.17
> ----
> 
> Have queued the following patch instead.

Thanks. Tested on AM437x GP EVM with today's linux-next. Works fine for me.

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140730/5a588b73/attachment.sig>
