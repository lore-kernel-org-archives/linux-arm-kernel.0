From: behanw@converseincode.com (Behan Webster)
Date: Thu, 08 May 2014 18:17:43 -0700
Subject: [PATCH] mpilib: use 'static inline' for mpi-inline.h
In-Reply-To: <20140508113013.74b2eb9d@gandalf.local.home>
References: <1399560433-1402630-1-git-send-email-arnd@arndb.de>	<1399560990-1402858-1-git-send-email-arnd@arndb.de>	<1399560990-1402858-9-git-send-email-arnd@arndb.de>
 <20140508113013.74b2eb9d@gandalf.local.home>
Message-ID: <536C2CB7.1060600@converseincode.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/08/14 08:30, Steven Rostedt wrote:
> On Thu,  8 May 2014 16:56:20 +0200
> Arnd Bergmann <arnd@arndb.de> wrote:
>
>> Four functions of mpilib are defined as 'extern inline' at the
>> moment, which is generally not the correct way to do inline functions
>> using gcc.
> I think clang would appreciate this too.
Indeed. Saves me writing the same patch. :)

Behan

-- 
Behan Webster
behanw at converseincode.com
