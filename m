From: tony@atomide.com (Tony Lindgren)
Date: Mon, 6 Jul 2015 05:31:27 -0700
Subject: [RESEND] [PATCH v2 1/2] arm: devtree: Set system_rev from DT
 revision
In-Reply-To: <201507061423.23505@pali>
References: <1430902142-17035-1-git-send-email-pali.rohar@gmail.com>
 <20150506114417.GI30910@pali> <20150625050138.GL4156@atomide.com>
 <201507061423.23505@pali>
Message-ID: <20150706123126.GG10705@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Pali Roh?r <pali.rohar@gmail.com> [150706 05:25]:
>
> into which file should I put documentation about new DT properties?

If it's Linux generic like linux,revision, then how about
Documentation/devicetree/bindings/revision.txt?

For the ATAGs, Documentation/devicetree/bindings/arm/atag.txt?

Regards,

Tony
