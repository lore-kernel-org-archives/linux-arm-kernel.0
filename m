From: linux@prisktech.co.nz (Tony Prisk)
Date: Thu, 16 Aug 2012 10:18:52 +0000
Subject: [PATCHv2 0/8] *** ARM: Update arch-vt8500 to Devicetree ***
In-Reply-To: <502BF734.9000608@wwwdotorg.org>
References: <1344477300-25251-1-git-send-email-linux@prisktech.co.nz>,
 <502BF734.9000608@wwwdotorg.org>
Message-ID: <76F764B079F92A4E843589C893D0A022D62814E9@SERVER.prisktech.co.nz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>>On 08/08/2012 07:54 PM, Tony Prisk wrote:
>> This patchset updates arch-vt8500 to devicetree and removes all the old-style
>> code. Support for WM8650 has also been added.

>Sorry for taking such a long time to re-review this.

>I scanned the series looking for just the changes to the issues I raised
>on v1, and I do see almost everything has been fixed up OK, except for
>the one issue I just commented on. So, aside from that, this series is
>fine by me. I'll defer to others about whether it's necessary to fix the
>display node-name-vs.-phandle issue I pointed out, or defer that until
>later.

Thanks for the review Stephen.

There will be a v3 shortly - I noticed a few other issues that needed to
be corrected as well. I agree with the display-node/phandle comment
and will make sure its included for v3. To be honest, it just slipped my
memory at the time.

Tony Prisk
