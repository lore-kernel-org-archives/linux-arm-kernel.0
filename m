From: gilles.chanteperdrix@xenomai.org (Gilles Chanteperdrix)
Date: Wed, 04 Nov 2009 23:09:40 +0100
Subject: GCC built-in atomic operations and memory barriers
In-Reply-To: <20091104190544.GA518@n2100.arm.linux.org.uk>
References: <4AF1C361.8090405@45mercystreet.com>
	<20091104190544.GA518@n2100.arm.linux.org.uk>
Message-ID: <4AF1FBA4.4070307@xenomai.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux wrote:
> The kernel API is the syscall interface and associated data structures.
> It does not include everything you can find in kernel headers.

Are the functions found in the vectors page part of the kernel API?
Because if that is so, then they provide a way to implement cmpxchg and
barriers in user-space.

-- 
					    Gilles.
