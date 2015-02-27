From: pali.rohar@gmail.com (Pali =?utf-8?q?Roh=C3=A1r?=)
Date: Fri, 27 Feb 2015 16:45:58 +0100
Subject: [PATCH] ARM: /proc/cpuinfo: DT: Add support for Revision
In-Reply-To: <CAL_JsqLvj3zW9v+R3y8uOi8ZCPj5Q+NT057j-8URHavDeWqUAQ@mail.gmail.com>
References: <1403110464-29646-1-git-send-email-pali.rohar@gmail.com>
 <201501301514.14884@pali>
 <CAL_JsqLvj3zW9v+R3y8uOi8ZCPj5Q+NT057j-8URHavDeWqUAQ@mail.gmail.com>
Message-ID: <201502271645.58765@pali>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 30 January 2015 22:03:36 Rob Herring wrote:
> lOn Fri, Jan 30, 2015 at 8:14 AM, Pali Roh?r 
<pali.rohar@gmail.com> wrote:
> > On Monday 26 January 2015 21:22:27 Rob Herring wrote:
> >> On Mon, Jan 26, 2015 at 1:09 PM, Pali Roh?r
> > 
> > <pali.rohar@gmail.com> wrote:
> >> > Ok, here is patch which set Revision field (global
> >> > variable
> 
> >> > system_rev) in /proc/cpuinfo from DT revision property:
> [...]
> 
> >> > I do not know which DT property to use for storing HW
> >> > Revision, so if "/revision" is not correct one, let me
> >> > know what to use instead. Also you can add my
> >> > Signed-off-by for both patches.
> >> 
> >> It is the correct property, but /revision in DT is a
> >> string.
> >> 
> >> You need to add your own sign-off.
> >> 
> >> Rob
> > 
> > Any documentation which says that /revision is string?
> 
> Sorry, I was confusing this with serial-number, so I guess a
> number is fine here.
> 
> > If it is really string, how to store ATAG_REVISON (number)
> > to string? dec or hex?
> 
> However /proc/cpuinfo displays it would be fine if you stay
> with a string.
> 
> Rob

I will send new patch which will store number value as string. So 
same output will be in /proc/cpuinfo and in DT /revision.

-- 
Pali Roh?r
pali.rohar at gmail.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150227/f30eeba9/attachment.sig>
