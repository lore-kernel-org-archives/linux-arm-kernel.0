From: olof@lixom.net (Olof Johansson)
Date: Thu, 20 Feb 2014 00:31:52 -0800
Subject: [GIT PULL] Renesas CPG update for v3.15
In-Reply-To: <20140220081833.GD19089@quad.lixom.net>
References: <cover.1391651474.git.horms+renesas@verge.net.au>
 <20140220081833.GD19089@quad.lixom.net>
Message-ID: <CAOesGMj5oNAXKB3GwMLc1RhfNpZP0-J7b4m9RqFAPGUa+jTHqA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 20, 2014 at 12:18 AM, Olof Johansson <olof@lixom.net> wrote:
> On Thu, Feb 06, 2014 at 03:14:00PM +0900, Simon Horman wrote:
>> Hi Olof, Hi Kevin, Hi Arnd,
>>
>> please consider this Renesas CPG update for v3.15.
>>
>>
>> The following changes since commit 38dbfb59d1175ef458d006556061adeaa8751b72:
>>
>>   Linus 3.14-rc1 (2014-02-02 16:42:13 -0800)
>>
>> are available in the git repository at:
>>
>>   git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-cpg-for-v3.15
>>
>> for you to fetch changes up to a028c6da34d434e35ba8322568c756ea97ff3c18:
>>
>>   ARM: shmobile: wait for MSTP clock status to toggle, when enabling it (2014-02-04 10:22:39 +0900)
>>
>> ----------------------------------------------------------------
>> Renesas CPG update for v3.15
>>
>> * Wait for MSTP clock status to toggle when enabling it
>
> Hi Simon,
>
> Is there a reason this is coming to arm-soc instead of to the clk tree
> maintainer?

Nevermind, I came across the dependent branch now.


-Olof
