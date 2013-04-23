From: gang.chen@asianux.com (Chen Gang)
Date: Tue, 23 Apr 2013 18:54:02 +0800
Subject: [PATCH] ARM64: kernel: compiling issue, define cmpxchg64 and
 cmpxchg64_local for outside using.
In-Reply-To: <20130423104851.GC23407@arm.com>
References: <51712E5E.2020809@asianux.com> <201304191412.54601.arnd@arndb.de>
 <5171FD67.2080104@asianux.com> <2182812.ymprEm6XBb@wuerfel>
 <5174C5D9.3060109@asianux.com> <20130423104851.GC23407@arm.com>
Message-ID: <5176684A.2080600@asianux.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2013?04?23? 18:48, Catalin Marinas wrote:
> On Mon, Apr 22, 2013 at 06:08:41AM +0100, Chen Gang wrote:
>> > 
>> >   drivers use cmpxchg64, cmpxchg64_local ... to perform 64-bit operation,
>> >   so they can cross 32-bit and 64-bit platforms (it is a standard way).
>> > 
>> > 
>> > Signed-off-by: Chen Gang <gang.chen@asianux.com>
> Applied, thanks.


Thanks too. I should continue to find and make new patches for arm64.


-- 
Chen Gang

Asianux Corporation
