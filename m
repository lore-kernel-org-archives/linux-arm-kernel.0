From: hpa@zytor.com (H. Peter Anvin)
Date: Fri, 18 Jul 2014 11:36:54 -0700
Subject: [PATCH v3] arm64, ia64, ppc, s390, sh, tile, um, x86,
 mm: Remove default gate area
In-Reply-To: <CALCETrXve-=N5yzqDw2YQee4BmC6sb8GYWYJcV2780V38OuJiQ@mail.gmail.com>
References: <70f331f59e620dc4e66bd3fa095e6f6b744b532b.1405281639.git.luto@amacapital.net>
 <CALCETrXG6nL4K=Er+kv5-CXBDVa0TLg9yR6iePnMyE2ufXgKkw@mail.gmail.com>
 <20140718101416.GB1818@arm.com> <53C8F4DF.8020103@nod.at>
 <CALCETrXve-=N5yzqDw2YQee4BmC6sb8GYWYJcV2780V38OuJiQ@mail.gmail.com>
Message-ID: <53C96946.4090304@zytor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/18/2014 09:53 AM, Andy Lutomirski wrote:
> 
> Splitting this will be annoying: I'd probably have to add a flag asking for
> the new behavior, update all the arches, then remove the flag.  The chance
> of screwing up bisectability in the process seems pretty high.  This seems
> like overkill for a patch that mostly deletes code.
> 
> Akpm, can you take this?
> 

I'm fine with it as-is.

Acked-by: H. Peter Anvin <hpa@linux.intel.com>
