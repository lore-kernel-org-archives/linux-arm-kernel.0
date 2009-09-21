From: kirill@shutemov.name (Kirill A. Shutemov)
Date: Mon, 21 Sep 2009 14:19:57 +0300
Subject: [PATCH v3 1/2] ARM: Introduce ARM_L1_CACHE_SHIFT to define cache
	line size
In-Reply-To: <20090921083724.GA27357@n2100.arm.linux.org.uk>
References: <188e5f14411c04ec999ef25bfe3616f77f1387b0.1252788311.git.kirill@shutemov.name>
	<20090921083724.GA27357@n2100.arm.linux.org.uk>
Message-ID: <cc557aab0909210419x795d407erfc07ad0f4550ed88@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 21, 2009 at 11:37 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Sat, Sep 12, 2009 at 11:48:30PM +0300, Kirill A. Shutemov wrote:
>> Currently kernel believes that all ARM CPUs have L1_CACHE_SHIFT == 5.
>> It's not true at least for CPUs based on Cortex-A8.
>
> Please send this to the patch system. ?There's no need to add the "V2"
> comments to it when you do.
>

#5716, #5717

BTW, I ,my pathes without change log in your git tree. Commits 910a17e
and dca230f. What is wrong with it?
