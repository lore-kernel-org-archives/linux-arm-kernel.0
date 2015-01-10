From: torvalds@linux-foundation.org (Linus Torvalds)
Date: Sat, 10 Jan 2015 11:42:47 -0800
Subject: Linux 3.19-rc3
In-Reply-To: <20150110104627.GA8281@rhlx01.hs-esslingen.de>
References: <CA+55aFy+7+-8CHpmOjRXh1txpABRK3PC+7yZ+fESVAmveOWDyw@mail.gmail.com>
 <20150110104627.GA8281@rhlx01.hs-esslingen.de>
Message-ID: <CA+55aFw_QqayT8mYJP-wPjs0FuGo8rBiUv00+CzQrQotgn6bPw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 10, 2015 at 2:46 AM, Andreas Mohr <andi@lisas.de> wrote:
>
> Yet that is what any VirtualAlloc() call on Windows does
> One thing less left to wonder why 'doze is such a performance pig...

Well, to be fair, you shouldn't use VirtualAlloc() as some 'malloc()'
replacement. It's  more of a backing store allocator for malloc() and
friends than anything else.

                         Linus
