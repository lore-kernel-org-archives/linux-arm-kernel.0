From: eric.y.miao@gmail.com (Eric Miao)
Date: Wed, 2 Dec 2009 14:00:20 +0800
Subject: strange, spurious seeming vector exception on pxa300
In-Reply-To: <4B159524.2020408@comrex.com>
References: <4B159524.2020408@comrex.com>
Message-ID: <f17812d70912012200m4532317eue21baf5e10925455@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 2, 2009 at 6:13 AM, Yeasah Pell <yeasah@comrex.com> wrote:
> Has anybody ever seen vector exceptions happen on an ARM (xscale, pxa300)
> without 26-bit mode being used? I have some application and kernel code
> which appears to work on most hardware, but we have at least one board which
> causes periodic messages:
>
> Unhandled fault: vector exception (0x010) at 0x412c8a90
>
> (I also fudged the fault handler a bit to dump the SPSR: 0x80000010)

Never had such exceptions. This is weird, SPSR[4] == 1 indicates a 32-bit mode.
