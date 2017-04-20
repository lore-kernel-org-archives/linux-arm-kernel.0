From: eric@anholt.net (Eric Anholt)
Date: Thu, 20 Apr 2017 13:12:10 -0700
Subject: [PATCH] ARM: dts: Add devicetree for the Raspberry Pi 3,
 for arm32 (v4)
In-Reply-To: <9c076a1e-267a-1a66-7cc0-9dd5bf59c5a8@gmail.com>
References: <20170330002605.15213-1-eric@anholt.net>
 <9c076a1e-267a-1a66-7cc0-9dd5bf59c5a8@gmail.com>
Message-ID: <877f2e96ud.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Florian Fainelli <f.fainelli@gmail.com> writes:

> On 03/29/2017 05:26 PM, Eric Anholt wrote:
>> Raspbian and Fedora have decided to support the Pi3 in 32-bit mode for
>> now, so it's useful to be able to test that mode on an upstream
>> kernel.  It's also been useful for me to use the same board for 32-bit
>> and 64-bit development.
>> 
>> Signed-off-by: Eric Anholt <eric@anholt.net>
>> ---
>> 
>> v1: Gerd's patch that put the ../../../arm64/... link in the Makefile
>> v2: Michael's patch that #included from ../../../arm64/... in a new
>>     bcm2837-rpi-3-b.dts.
>> v3: Mine, using symlinks to make sure that we don't break the split DT
>>     tree.
>> v4: Rely on the new include/arm64 symlink.
>> 
>> Assuming positive review feedback, I assume it would be acceptable to
>> merge the shared/dt-symlinks branch in a PR of my own for the 32-bit
>> DT branch?
>
> Either that, or I can take it directly through devicetree/next whichever
> you prefer. We have not gotten feedback on whether this looks acceptable
> or not though...

I would love if you could pull this patch, but it does require
shared/dt-symlinks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 832 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170420/ece011ff/attachment.sig>
