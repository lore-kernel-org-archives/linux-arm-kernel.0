From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Tue, 24 Jul 2012 16:54:27 +0400
Subject: [PATCH V3 1/2] of: Add generic device tree DMA helpers
In-Reply-To: <500DC255.40900@wwwdotorg.org>
References: <1335820679-28721-1-git-send-email-jon-hunter@ti.com>
 <201206271520.49276.arnd@arndb.de> <1342161907.1726.26.camel@vkoul-udesk3>
 <201207171924.33756.arnd@arndb.de> <500DC255.40900@wwwdotorg.org>
Message-ID: <500E9B03.20706@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 24-07-2012 1:29, Stephen Warren wrote:

>> I think we're basically on the same page. Let's see if I have covered
>> all the cases we discussed so far. I've tried to update the binding that
>> Jon sent out initially with everything we've discussed, so please review
>> this to see if I understood you correctly.
> ...
>> * DMA client
> ...
>> Examples:
> ...
>> 3. A device with three channels, one of which has two alternatives:

> s/three/four/   s/one of which/both of which/

    You can't say "both" of 4 channels, only "all". :-)

WBR, Sergei
