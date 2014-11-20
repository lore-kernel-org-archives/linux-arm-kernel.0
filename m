From: jkosina@suse.cz (Jiri Kosina)
Date: Thu, 20 Nov 2014 14:51:08 +0100 (CET)
Subject: [PATCH RESEND] ARM: dts: bcm63138: change "interupts" to
 "interrupts"
In-Reply-To: <1416235278-15759-1-git-send-email-radek.dostal@streamunlimited.com>
References: <5460F9EF.5010605@gmail.com>
 <1416235278-15759-1-git-send-email-radek.dostal@streamunlimited.com>
Message-ID: <alpine.LNX.2.00.1411201450180.4454@pobox.suse.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 17 Nov 2014, Radek Dostal wrote:

> all other nodes in bcm63138.dtsi use "interrupts", this had to be just a typo
> which never got noticed, even it may have quite some consequences.
> 
> Signed-off-by: Radek Dostal <radek.dostal@streamunlimited.com>
> Acked-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  Dear all,
> 
>  resending the previous patch with added Acked-by from Florian Fainelli. I
>  did not hear anything back for almost a week. Additionally CC to
>  trivial at kernel.org as it may qualify for it.

As this got acked by Florian and I don't see it in linux-next as of today, 
I am taking it.

-- 
Jiri Kosina
SUSE Labs
