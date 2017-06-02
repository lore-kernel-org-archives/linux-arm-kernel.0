From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 02 Jun 2017 11:18:44 +0200
Subject: [GIT PULL] ARM: mvebu: fixes for v4.12 (#1)
In-Reply-To: <20170601235745.GF13314@localhost> (Olof Johansson's message of
 "Thu, 1 Jun 2017 16:57:45 -0700")
References: <87d1ansq6c.fsf@free-electrons.com>
 <20170601235745.GF13314@localhost>
Message-ID: <878tlarbm3.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof,
 
 On ven., juin 02 2017, Olof Johansson <olof@lixom.net> wrote:

> On Thu, Jun 01, 2017 at 05:06:35PM +0200, Gregory CLEMENT wrote:
>> Hi,
>> 
>> Here is the first pull request for fixes for mvebu for v4.12.
>> 
>> Gregory
>> 
>> The following changes since commit 08332893e37af6ae779367e78e444f8f9571511d:
>> 
>>   Linux 4.12-rc2 (2017-05-21 19:30:23 -0700)
>> 
>> are available in the git repository at:
>> 
>>   git://git.infradead.org/linux-mvebu.git tags/mvebu-fixes-4.12-1
>
> So, it's really appreciated from our side if you take a look at our tree to see
> what the base for our own fixes branch is, and pick the same or older base for
> your contents.
>
> In this case, we're still at -rc1 and you're on -rc2, so this included
> a backmerge of -rc2 into our branch. It's nice to avoid if we can, but it's
> also not a huge deal.

I used the rc2 as a base because some mvebu related patches I sent close
to the opening of the 4.12 merge windows were merged in 4.12-rc2.

I wanted to avoid future potential conflict on hte fixes branch.

Thanks,

Gregory

>
>
> Merged to fixes.
>
>
> -Olof

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
