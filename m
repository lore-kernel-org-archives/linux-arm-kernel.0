From: murzin.v@gmail.com (Vladimir Murzin)
Date: Fri, 25 Apr 2014 09:43:55 +0100
Subject: [Xen-devel] [PATCH RFC] arm64: 32-bit tolerant sync bitops
In-Reply-To: <1398410237.23380.37.camel@dagon.hellion.org.uk>
References: <1397723881-31648-1-git-send-email-murzin.v@gmail.com>
 <534FB009.5030904@citrix.com>
 <1398241889.4880.96.camel@kazak.uk.xensource.com>
 <20140422205656.GA4467@hp530>
 <1398410237.23380.37.camel@dagon.hellion.org.uk>
Message-ID: <CABV+yWtZWcmxTawAVurL4Ua0iCF3FK0x+xqzm4zeEv_d2xqgkw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 25, 2014 at 8:17 AM, Ian Campbell <Ian.Campbell@citrix.com> wrote:
> On Tue, 2014-04-22 at 21:56 +0100, Vladimir Murzin wrote:
>> Might be dealing with it on Xen side is only way unless arm64 folks say what
>> they think...
>
>
> I don't expect the arm64 guys will have any interesting in changing the
> bitops in this way. So please can you fix this on the Xen side, perhaps
> in the way I suggested.
>
> If at some point arm64 does gain 32-bit capable bitops we can always
> switch back to using them directly again.
>
> In the meantime we need to get this Xen regression fixed before 3.15. If
> you don't have time to work on this please let us know.
>
> Ian.
>
Hi Ian

I'll try to cook some patches for that.

Vladimir
