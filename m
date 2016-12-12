From: peter@korsgaard.com (Peter Korsgaard)
Date: Mon, 12 Dec 2016 21:42:01 +0100
Subject: [PATCH 0/2] ARM: v7-A !MMU fixes for fun (&fame)
In-Reply-To: <20161212184429.GA5219@afzalpc> (Afzal Mohammed's message of
 "Tue, 13 Dec 2016 00:14:29 +0530")
References: <20161211131028.3019-1-afzal.mohd.ma@gmail.com>
 <20161212184429.GA5219@afzalpc>
Message-ID: <87fuls517q.fsf@dell.be.48ers.dk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>>>>> "Afzal" == Afzal Mohammed <afzal.mohd.ma@gmail.com> writes:

 > Hi,
 > On Sun, Dec 11, 2016 at 06:40:28PM +0530, Afzal Mohammed wrote:

 >> Kernel reached the stage of invoking user space init & panicked, though
 >> it could not reach till prompt for want of user space executables
 >> 
 >> So far i have not come across a toolchain (or a way to create toolchain)
 >> to create !MMU user space executables for Cortex-A.

 > Now able to reach prompt using buildroot initramfs, Thanks to
 > Peter Korsgaard for suggesting the way to create user space executables
 > for !MMU Cortex-A.

Great, thats nice to hear!

-- 
Bye, Peter Korsgaard
