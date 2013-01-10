From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 10 Jan 2013 11:24:58 +0000
Subject: [RFC PATCH 1/7] ARM: common: vic: Parse interrupt and resume
 masks from device tree
In-Reply-To: <25622346.hsAr9IOJWj@flatron>
References: <1357774909-29938-1-git-send-email-tomasz.figa@gmail.com>
 <1357774909-29938-2-git-send-email-tomasz.figa@gmail.com>
 <20130110110314.GH20956@opensource.wolfsonmicro.com>
 <25622346.hsAr9IOJWj@flatron>
Message-ID: <20130110112458.GK20956@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 10, 2013 at 12:10:38PM +0100, Tomasz Figa wrote:

> This is not the runtime interrupt/wakeup mask, but a global mask of 
> available interrupt/wakeup lines on particular platform, which still have 
> to be configured and enabled appropriately by user.

Ah, OK.

Reviewed-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130110/29a757b2/attachment.sig>
