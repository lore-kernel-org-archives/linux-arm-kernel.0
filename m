From: cmetcalf@mellanox.com (Chris Metcalf)
Date: Tue, 23 May 2017 14:15:20 -0400
Subject: Updating kernel.org cross compilers?
In-Reply-To: <ee8a7f2c-976d-fe2a-55f9-ab8eebbf22eb@arm.com>
References: <92b5ff36-ad2b-10bc-de4f-4774babd9625@arm.com>
 <20170430052957.GJ19687@gate.crashing.org>
 <ee8a7f2c-976d-fe2a-55f9-ab8eebbf22eb@arm.com>
Message-ID: <eccd3410-d5a6-34eb-41f5-fb9849608621@mellanox.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/09/2017 10:59 AM, Andre Przywara wrote:
> On 30/04/17 06:29, Segher Boessenkool wrote:
>> On Wed, Apr 26, 2017 at 03:14:16PM +0100, Andre Przywara wrote:
>>> It seems that many people (even outside the Linux kernel community) use
>>> the cross compilers provided at kernel.org/pub/tools/crosstool.
>>> The latest compiler I find there is 4.9.0, which celebrated its third
>>> birthday at the weekend, also has been superseded by 4.9.4 meanwhile.
>>>
>>> So I took Segher's buildall scripts from [1] and threw binutils 2.28 and
>>> GCC 6.3.0 at them.

I am belatedly catching up on this thread.  It sounds like the
tilegx/tilepro issues were sorted out -- as someone noted, you need
to have the kernel headers available to build glibc.  However, if
there are any outstanding tile issues, please feel free to loop me in!

-- 
Chris Metcalf, Mellanox Technologies
http://www.mellanox.com
