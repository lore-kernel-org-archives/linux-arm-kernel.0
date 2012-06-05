From: kay@vrfy.org (Kay Sievers)
Date: Wed, 6 Jun 2012 01:39:57 +0200
Subject: [PATCH 0/8] Rework KERN_<LEVEL>
In-Reply-To: <1338939316.11962.3.camel@joe2Laptop>
References: <cover.1338889066.git.joe@perches.com>
 <20120605142826.d92316a0.akpm@linux-foundation.org>
 <1338934303.5780.8.camel@joe2Laptop>
 <20120605151754.a794ac7c.akpm@linux-foundation.org>
 <1338936572.5780.29.camel@joe2Laptop>
 <20120605162910.caccb0d4.akpm@linux-foundation.org>
 <1338939316.11962.3.camel@joe2Laptop>
Message-ID: <CAPXgP13J+8-dPpZkSfh9sM3xXujC2Rb9tJaOvGoEPghgdr8jiw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 6, 2012 at 1:35 AM, Joe Perches <joe@perches.com> wrote:
> On Tue, 2012-06-05 at 16:29 -0700, Andrew Morton wrote:
>> What about writes starting with \001n? ?AFACIT, that will be stripped
>> away and the printk level will be altered. ?This is new behavior.
>
> Nope.
>
> # echo "\001Hello Andrew" > /dev/kmsg
> /dev/kmsg has
> 12,774,2462339252;\001Hello Andrew

Try "echo -e"? The stuff is copied verbatim otherwise.

Kay
