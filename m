From: eric@anholt.net (Eric Anholt)
Date: Fri, 29 May 2015 10:44:38 -0700
Subject: [PATCH 5/7] ARM: bcm2835: Drop the fixed sys_pclk.
In-Reply-To: <55679125.6000607@wwwdotorg.org>
References: <1431978219-14226-1-git-send-email-eric@anholt.net>
 <1431978219-14226-6-git-send-email-eric@anholt.net>
 <55679125.6000607@wwwdotorg.org>
Message-ID: <87iobb46t5.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stephen Warren <swarren@wwwdotorg.org> writes:

> On 05/18/2015 01:43 PM, Eric Anholt wrote:
>> Nothing uses it, and I can't find any evidence that anything ever has.
>
> Does the clock actually exist though? If it does, it seems reasonable to
> keep it.

Yes, it's kept in the form of the core clock in the RPi driver, and the
clock-frequency values in spi and i2c in bcm2835.dtsi.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150529/733f9b02/attachment-0001.sig>
