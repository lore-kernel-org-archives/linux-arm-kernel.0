From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 26 Jan 2012 20:26:30 +0000
Subject: [PATCH v3] ARM: support XZ compressed kernels
In-Reply-To: <4F20353E.70809@bluegiga.com>
References: <1320696216-5570-1-git-send-email-kaloz@openwrt.org>
 <CACRpkdb1RhmB4d2DfWp4B3OVybt-NMnku-fo+bHDuPWdi9LddQ@mail.gmail.com>
 <op.v4vsotxk2s3iss@ecaz> <4F180128.9060005@bluegiga.com>
 <op.v8bxi2yu2s3iss@ecaz> <4F20353E.70809@bluegiga.com>
Message-ID: <20120126202630.GB11941@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 25, 2012 at 07:00:46PM +0200, Veli-Pekka Peltola wrote:
> Hi Imre,
>
> On 01/19/2012 01:43 PM, Imre Kaloz wrote:
>> Recent changes introduced an error, but Nico helped me clean that up.
>> Will submit the final patch to the patch system this weekend.
>
> Just a reminder: I was unable to find this from the patch tracking  
> system. Any updates? Can I help somehow?

Well, this is where things got to last time around:

http://lists.arm.linux.org.uk/lurker/message/20110722.200731.32f090d9.en.html

and then everything stopped.  No further feedback, nothing.  So I've
been totally ignoring XZ stuff because I've been believing that the
issue hasn't been fixed.

It seems that it has now been fixed, back in July.  Nice to have been
told about that development, etc.

So yes, as the problem has been resolved, we can now move forward on
it.  I'm not sure it's -rc material though, so I'll queue it for the
next merge window.  We've waited six months already since the 'fix'
went in, so plainly another three won't hurt one bit.
