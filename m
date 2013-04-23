From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 23 Apr 2013 11:48:51 +0100
Subject: [PATCH] ARM64: kernel: compiling issue, define cmpxchg64 and
 cmpxchg64_local for outside using.
In-Reply-To: <5174C5D9.3060109@asianux.com>
References: <51712E5E.2020809@asianux.com> <201304191412.54601.arnd@arndb.de>
 <5171FD67.2080104@asianux.com> <2182812.ymprEm6XBb@wuerfel>
 <5174C5D9.3060109@asianux.com>
Message-ID: <20130423104851.GC23407@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 22, 2013 at 06:08:41AM +0100, Chen Gang wrote:
> 
>   drivers use cmpxchg64, cmpxchg64_local ... to perform 64-bit operation,
>   so they can cross 32-bit and 64-bit platforms (it is a standard way).
> 
> 
> Signed-off-by: Chen Gang <gang.chen@asianux.com>

Applied, thanks.

-- 
Catalin
