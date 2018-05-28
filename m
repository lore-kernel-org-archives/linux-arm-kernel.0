From: gregory.clement@bootlin.com (Gregory CLEMENT)
Date: Mon, 28 May 2018 17:13:35 +0200
Subject: [GIT PULL] ARM: mvebu: arm for v4.18 (#1)
In-Reply-To: <20180525115718.o426ixt6bilonjnx@localhost> (Olof Johansson's
 message of "Fri, 25 May 2018 04:57:18 -0700")
References: <87603m1lq9.fsf@bootlin.com>
 <20180525115718.o426ixt6bilonjnx@localhost>
Message-ID: <87wovnx17k.fsf@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof,
 
 On ven., mai 25 2018, Olof Johansson <olof@lixom.net> wrote:

> On Thu, May 17, 2018 at 02:59:42PM +0200, Gregory CLEMENT wrote:
>> Hi,
>> 
>> Here is the first pull request for arm for mvebu for v4.18.
>> 
>> As I feared, there were (trivial) merge issues due to the defconfig
>> update in linux-next. The best place to solve them is in your tree, so
>> as soon as you will pull this, I will remove from my mvebu/for-next
>> branch.
>
> Hmm. Yeah, this is because you took upon yourself to run 'make savedefconfig'
> for all platforms on this shared defconfig. This will of course conflict with
> everything everywhere, and it doesn't seem like a good idea to do this way.
>
> What you're really doing here is turning on one single option? Just do that.
>
> We can run savedefconfig at the end of a merge window here instead of having
> one of the platform maintainers do it.

Great, so could you do it for this release (I mean 4.18)? Indeed the
multi_v7_defconfig had not been sync since a long time.

>
> So, feel free to send just the NAND patch, and I can fix it up when I apply it
> if needed.

OK I am going to send you this patch rebased on a clean v4.17-rc1.

Gregory

>
> Thanks!
>
>
> -Olof
>

-- 
Gregory Clement, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com
