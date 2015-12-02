From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 02 Dec 2015 14:49:52 +0100
Subject: linux-next: manual merge of the mvebu tree with the arm-soc tree
In-Reply-To: <2428665.BrOON4cELy@wuerfel> (Arnd Bergmann's message of "Wed, 02
 Dec 2015 12:21:21 +0100")
References: <20151202111244.b7ee49ee06b4a95e407e740d@kernel.org>
 <20151202111829.GE1929@sirena.org.uk> <2428665.BrOON4cELy@wuerfel>
Message-ID: <87bna92c5b.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,
 
 On mer., d?c. 02 2015, Arnd Bergmann <arnd@arndb.de> wrote:

> On Wednesday 02 December 2015 11:18:29 Mark Brown wrote:
>> On Wed, Dec 02, 2015 at 11:12:44AM +0000, Mark Brown wrote:
>> > Hi all,
>> > 
>> > Today's linux-next merge of the mvebu tree got a conflict in  between commit
>> > 377524dc4d77f50e ("ARM: mmp: move into ARCH_MULTIPLATFORM") from the arm-soc
>> > tree and commit 5f4423af9dd17 ("ARM: orion: multiplatform support") from the
>> > mvebu tree.
>> 
>> Ccing in Arnd since I forgot to do that.
>> 
>
> I was planning to merge all the multiplatform changes into one next/multiplatform
> branch, but the mvebu maintainers preferred to keep this one in their
> tree at

Indeed except the arch/arm/Kconfig file all the other files belong to
the mbebu subsystem and it is easier to to keep in our tree to handle them.

> least initially. The conflict will go away once it's tested sufficiently and
> I'm pulling it back.

By the way, when you will pull our tree, we will still have it our own
mvebu/for-next branch. Will git managed to automagically resolve the
conflict by getting the resolution you will do in your branch?

A another solution could be to have a separate patch for the
arch/arm/Kconfig file that you keep in arm-soc.

Gr?gory

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
