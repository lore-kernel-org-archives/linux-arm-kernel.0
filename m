From: Ganesh.Kumar@harman.com (Kumar, Ganesh)
Date: Tue, 28 May 2013 02:48:33 -0500
Subject: VDSO for arm 32bit
In-Reply-To: <20899.25935.838288.45383@pilspetsen.it.uu.se>
References: <634BB1CFA60ED14386C17849392C3EB202E52C9C0A@HICGWSEX01.ad.harman.com>
 <20899.25935.838288.45383@pilspetsen.it.uu.se>
Message-ID: <634BB1CFA60ED14386C17849392C3EB202E52C9E87@HICGWSEX01.ad.harman.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mikel,

Kumar, Ganesh writes:
 > Hi All,
 >
 > ? I'm working on OMAP5 on greg's LTS kernel 3.4.25, but I see there is  > no support for vdso for arm 32 bit.
 > I'm planning to port it to arm 32 bit, is there any work under progress?
 > would like to understand why the support for arm 32 bit is not there, any idea?

> 32-bit ARM has a "kuser" page at a fixed virtual address, which exports a few critical routines to user-space.  With that, a vdso is mostly redundant.

  Thanks for the info, my main idea is to get the gettimeofday exported through the kuser helper,tried looking at the sources
but I could not find anything related to that seems done in the mainline kernel tree for arm cortex, am I missing something here?
I plan to do that if its not available yet, right now I've started with the kernel doc for the kuser, any pointers further
to get the gettimeofday up and running using the kuser, Thanks in advance for your time.

--GK
