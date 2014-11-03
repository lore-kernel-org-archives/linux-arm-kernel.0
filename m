From: Yalin.Wang@sonymobile.com (Wang, Yalin)
Date: Mon, 3 Nov 2014 10:17:15 +0800
Subject: [RFC V6 3/3] arm64:add bitrev.h file to support rbit instruction
In-Reply-To: <20141031104305.GC6731@arm.com>
References: <35FD53F367049845BC99AC72306C23D103E010D18260@CNBJMBX05.corpusers.net>
 <35FD53F367049845BC99AC72306C23D103E010D18261@CNBJMBX05.corpusers.net>
 <35FD53F367049845BC99AC72306C23D103E010D18264@CNBJMBX05.corpusers.net>
 <35FD53F367049845BC99AC72306C23D103E010D18265@CNBJMBX05.corpusers.net>
 <35FD53F367049845BC99AC72306C23D103E010D18266@CNBJMBX05.corpusers.net>
 <20141030120127.GC32589@arm.com>
 <CAKv+Gu9g5Q6fjPUy+P8YxkeDrH+bdO4kKGnxTQZRFhQpgPxaPA@mail.gmail.com>
 <20141030135749.GE32589@arm.com>
 <35FD53F367049845BC99AC72306C23D103E010D18272@CNBJMBX05.corpusers.net>
 <35FD53F367049845BC99AC72306C23D103E010D18274@CNBJMBX05.corpusers.net>
 <20141031104305.GC6731@arm.com>
Message-ID: <35FD53F367049845BC99AC72306C23D103E010D18287@CNBJMBX05.corpusers.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> From: Will Deacon [mailto:will.deacon at arm.com]
> > +#ifndef __ASM_ARM64_BITREV_H
> > +#define __ASM_ARM64_BITREV_H
> 
> Really minor nit, but we don't tend to include 'ARM64' in our header guards,
> so this should just be __ASM_BITREV_H.
> 
> With that change,
> 
>   Acked-by: Will Deacon <will.deacon@arm.com>
> 
I have send the patch to the patch system:
http://www.arm.linux.org.uk/developer/patches/search.php?uid=4025

8187/1 8188/1 8189/1

Just remind you that , should also cherry-pick Joe Perches's 
2 patches:
[PATCH] 6fire: Convert byte_rev_table uses to bitrev8
[PATCH] carl9170: Convert byte_rev_table uses to bitrev8

To make sure there is no build error when build these 2 drivers.

Thanks
