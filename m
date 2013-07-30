From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Tue, 30 Jul 2013 08:45:52 +0300
Subject: [PATCH v2 6/9] ARM: msm: Move mach/board.h contents to common.h
In-Reply-To: <20130729202031.GA20694@codeaurora.org>
References: <1374699274-18388-1-git-send-email-sboyd@codeaurora.org>
 <1374699274-18388-7-git-send-email-sboyd@codeaurora.org>
 <20130729202031.GA20694@codeaurora.org>
Message-ID: <51F75310.80403@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29/07/13 23:20, David Brown wrote:
> On Wed, Jul 24, 2013 at 01:54:31PM -0700, Stephen Boyd wrote:
>> The contents of mach/board.h are only used by files within
>> mach-msm so there is no need to export this file outside of the
>> mach-msm directory. Move the contents of the file to common.h to
>> allow us to compile MSM in the multi-platform kernel.
>>
>> Cc: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
>> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
>> ---
>> drivers/video/msm/msm_fb.c             |  1 -
> 
> It'd be nice to get a framebuffer Ack from this part.
> 
> original patch:
>  https://patchwork.kernel.org/patch/2833029/

Acked-by: Tomi Valkeinen <tomi.valkeinen@ti.com>

 Tom


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 901 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130730/230e8445/attachment.sig>
