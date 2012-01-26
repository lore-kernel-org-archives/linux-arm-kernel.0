From: kaloz@openwrt.org (Imre Kaloz)
Date: Thu, 26 Jan 2012 21:51:20 +0100
Subject: [PATCH v3] ARM: support XZ compressed kernels
In-Reply-To: <20120126202630.GB11941@n2100.arm.linux.org.uk>
References: <1320696216-5570-1-git-send-email-kaloz@openwrt.org>
 <CACRpkdb1RhmB4d2DfWp4B3OVybt-NMnku-fo+bHDuPWdi9LddQ@mail.gmail.com>
 <op.v4vsotxk2s3iss@ecaz> <4F180128.9060005@bluegiga.com>
 <op.v8bxi2yu2s3iss@ecaz> <4F20353E.70809@bluegiga.com>
 <20120126202630.GB11941@n2100.arm.linux.org.uk>
Message-ID: <op.v8pljuvl2s3iss@ecaz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On Thu, 26 Jan 2012 21:26:30 +0100, Russell King - ARM Linux  
<linux@arm.linux.org.uk> wrote:

>> Just a reminder: I was unable to find this from the patch tracking
>> system. Any updates? Can I help somehow?
>
> Well, this is where things got to last time around:
>
> http://lists.arm.linux.org.uk/lurker/message/20110722.200731.32f090d9.en.html
>
> and then everything stopped.  No further feedback, nothing.  So I've
> been totally ignoring XZ stuff because I've been believing that the
> issue hasn't been fixed.
>
> It seems that it has now been fixed, back in July.  Nice to have been
> told about that development, etc.

As far as I know in the private mails that part has been cleared up with  
Lasse - you were CC'd all the time.

> So yes, as the problem has been resolved, we can now move forward on
> it.  I'm not sure it's -rc material though, so I'll queue it for the
> next merge window.  We've waited six months already since the 'fix'
> went in, so plainly another three won't hurt one bit.

When I've noticed v2 didn't get upstream without that change, I did a v3,  
and got no response for that from you [1]. Than the string.c related  
changes broke that, hence this (v4) version. If possible, please try to  
get this into 3.3, as I think there's no chance it could break anything.


Imre


[1]  
http://lists.arm.linux.org.uk/lurker/message/20111107.200336.feeeb3c5.en.html
