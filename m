From: fweisbec@gmail.com (Frederic Weisbecker)
Date: Wed, 30 Sep 2009 09:56:20 +0200
Subject: performance counter support for ARM architecture
In-Reply-To: <bbfde6e10909300026hbccd169s71a5ad1cd45ff944@mail.gmail.com>
References: <bbfde6e10909300026hbccd169s71a5ad1cd45ff944@mail.gmail.com>
Message-ID: <20090930075618.GA5784@nowhere>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 30, 2009 at 12:56:18PM +0530, nelakurthi koteswararao wrote:
> Dear all,
> 
> I will change the naming conventions and symbolic names once perfcounter for
> ARM is supported.
> I want to do intermediate releases for review in mean time
> 
> 1. I am able to support page faults in ARM with the attached patch along
> with application.( this is for linux-2.6.29 kernel)



Perf counters wasn't even in the 2.6.29 kernel so
I guess you are basing this work on a completely out of date
perf version.

We can't take patches based on 29. We can't even review
them, that doesn't make sense given the tons of things that have
changed since 2.6.29

We need patches against 2.6.32-rc1
