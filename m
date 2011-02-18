From: eric.y.miao@gmail.com (Eric Miao)
Date: Fri, 18 Feb 2011 10:24:52 +0800
Subject: [PATCH 1/2] ARM: PXA: PXAFB: Fix double-free issue.
In-Reply-To: <20110217185609.GB30606@n2100.arm.linux.org.uk>
References: <201102151718.00800.anarsoul@gmail.com>
	<1297928588-10545-1-git-send-email-anarsoul@gmail.com>
	<201102171917.41442.marek.vasut@gmail.com>
	<20110217185609.GB30606@n2100.arm.linux.org.uk>
Message-ID: <AANLkTindC1XUTgh+dyn9oQBXMZoKMFnxw9e63RraV6hc@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 18, 2011 at 2:56 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Thu, Feb 17, 2011 at 07:17:41PM +0100, Marek Vasut wrote:
>> Why are you getting rid of the atomic operations ?
>
> Because they're idiotic. ?Just because something is called "atomic"
> doesn't make it so, and this is one instance where it's absolutely
> useless.

Yep, I completely agree that's useless here.
