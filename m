From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Mon, 18 Apr 2016 12:10:56 +0300
Subject: [PATCH 1/7 RESEND] video: ARM CLCD: runtime check for Versatile
In-Reply-To: <CACRpkdYAcVy+PA5nXnWjWoLhh0UQm1=WMAzXiJtgcK0TsEa=zA@mail.gmail.com>
References: <1456221704-5792-1-git-send-email-linus.walleij@linaro.org>
 <1456221704-5792-2-git-send-email-linus.walleij@linaro.org>
 <CACRpkdYAcVy+PA5nXnWjWoLhh0UQm1=WMAzXiJtgcK0TsEa=zA@mail.gmail.com>
Message-ID: <5714A4A0.3090900@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 15/04/16 14:47, Linus Walleij wrote:
> On Tue, Feb 23, 2016 at 11:01 AM, Linus Walleij
> <linus.walleij@linaro.org> wrote:
> 
>> The current compile-time check for inversed IENB/CNTL does not
>> work in multiplatform boots: as soon as versatile is included
>> in the build, the IENB/CNTL is switched and breaks graphics.
>> Convert this to a runtime switch.
>>
>> Cc: stable at vger.kernel.org
>> Cc: Rob Herring <robh@kernel.org>
>> Cc: Russell King <linux@arm.linux.org.uk>
>> Fixes: a29da136de34 ("ARM: versatile: convert to multi-platform")
>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> 
> Tomi can you PLEASE merge this patch which is regressing all
> the Versatile hardware since commit a29da136de34?
> 
> It is not dependent on the rest of the series.
> 
> I am coming back to revising the rest of the patches, but
> this one need to go in.

Sure, queued for 4.6 fixes.

 Tomi

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160418/5ddb838d/attachment.sig>
