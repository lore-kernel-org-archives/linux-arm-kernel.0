From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 17 Aug 2011 10:01:03 +0200
Subject: [PATCH v2] amba: consolidate PrimeCell magic
In-Reply-To: <ADE657CA350FB648AAC2C43247A983F001F3884BB0A3@AUSP01VMBX24.collaborationhost.net>
References: <1313484514-25412-1-git-send-email-linus.walleij@stericsson.com>
	<ADE657CA350FB648AAC2C43247A983F001F3884BB0A3@AUSP01VMBX24.collaborationhost.net>
Message-ID: <CACRpkdY2Lvnd_fej9gB4s35v2Rcho5Na6Ky7MGe5Fkii=RQA3A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 16, 2011 at 6:19 PM, H Hartley Sweeten
<hartleys@visionengravers.com> wrote:

> Hmm.. ?Could this also be used in arch/arm/common/vic.c vic_init()?
>
> Here's the relevant code from that function:

You're right (as usual).

I'll cook a v3.

Thanks!
Linus Walleij
