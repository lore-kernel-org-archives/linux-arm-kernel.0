From: elezegarcia@gmail.com (Ezequiel Garcia)
Date: Wed, 23 Jan 2013 15:08:02 -0300
Subject: [PATCH v2 2/3] arm: mvebu: Enable USB controllers on Armada
 370/XP boards
In-Reply-To: <20130123190352.2d001218@skate>
References: <1358954792-16160-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1358954792-16160-2-git-send-email-ezequiel.garcia@free-electrons.com>
 <CALF0-+XJEXJ2B3NLu5DvyxaDuuMNP=zk+z8QUd4GTQULW3BpyA@mail.gmail.com>
 <20130123190352.2d001218@skate>
Message-ID: <CALF0-+W+dU5jvTeiX8pLan1hre7+Db3krD3KnW0XoFRvfkkoXQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

On Wed, Jan 23, 2013 at 3:03 PM, Thomas Petazzoni
<thomas.petazzoni@free-electrons.com> wrote:
> On Wed, 23 Jan 2013 14:04:42 -0300, Ezequiel Garcia wrote:
>
>> from the OpenBlocks AX3-4 board dts file, since you mentioned this
>> board uses that USB
>> port for a PCIe connector -- if I understood correctly.
>
> No. The OpenBlocks has a different USB controller that sits on the PCIe
> bus. There is nothing like a PCIe port that uses a USB port, that
> doesn't make sense.
>

Mmm... indeed, I got it completely wrong.

>> So, IMHO, if OpenBlocks uses third USB port to connect some PCIe
>> controller, we should activate it in the dts file.
>>
>> What do you think?
>
> No, see above.
>

So, what do you think about the patch series to be pushed as it is?

-- 
    Ezequiel
