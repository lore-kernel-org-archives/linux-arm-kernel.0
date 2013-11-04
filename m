From: michael.opdenacker@free-electrons.com (Michael Opdenacker)
Date: Mon, 04 Nov 2013 10:00:36 +0100
Subject: [PATCH] ARM: imx: removed unused MACH_MXLADS Kconfig parameter
In-Reply-To: <20131104085146.GT24559@pengutronix.de>
References: <1383542366-6270-1-git-send-email-michael.opdenacker@free-electrons.com>
 <20131104085146.GT24559@pengutronix.de>
Message-ID: <52776234.7030901@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sascha,

On 11/04/2013 09:51 AM, Sascha Hauer wrote:
> On Mon, Nov 04, 2013 at 06:19:26AM +0100, Michael Opdenacker wrote:
>> This removes the MACH_MXLADS Kconfig parameter,
>> which was no longer used anywhere in the source code
>> and Makefiles.
> Hehe, this one is a bit tricky. Indeed MACH_MXLADS isn't used directly
> anywhere. Nevertheless having CONFIG_MACH_MXLADS defined makes
> machine_is_mxlads() become true when the kernel is started with a
> machine id of 1851.
Oops, that's right, got it! Thanks!
>
> machine_is_mxlads() is unused in the kernel, so this patch indeed
> doesn't hurt. Anyway, the code is correct currently, so I suggest
> keeping it until the mx[1l]ads is either removed or converted to
> devicetree.
Sounds good to me.

Thanks for your review!

Cheers,

Michael.

-- 
Michael Opdenacker, CEO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
+33 484 258 098
