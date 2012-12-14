From: olof@lixom.net (Olof Johansson)
Date: Fri, 14 Dec 2012 10:06:53 -0800
Subject: [PATCHv2] ARM: sunxi: Change device tree naming scheme for sunxi
In-Reply-To: <50CB5D93.7080405@free-electrons.com>
References: <1355328503-25315-1-git-send-email-maxime.ripard@free-electrons.com>
 <201212131200.48413.arnd@arndb.de>
 <50CB5D93.7080405@free-electrons.com>
Message-ID: <CAOesGMgX6Ta9bduBEpuY-eLg_9Lvm19OMJMj2MPbHcfvj69wiw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Dec 14, 2012 at 9:10 AM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> Hi Arnd,
>
> Le 13/12/2012 13:00, Arnd Bergmann a ?crit :
>> On Wednesday 12 December 2012, Maxime Ripard wrote:
>>> There is several different SoCs sharing the sun5i codename: A10s, A12
>>> and A13. Since there is enough differences to not consider those the
>>> same SoCs, change a bit the naming scheme to reflect this.
>>>
>>> Moreover, some boards like the olinuxino come in A10s and A13 variants,
>>> which also share the same SoC codename.
>>>
>>> So change the naming scheme to reflect both the codename and the market
>>> name of the SoCs used in the dtsi and in the board files
>>>
>>> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
>>
>> Acked-by: Arnd Bergmann <arnd@arndb.de>
>
> Will you take it directly, or do you want a pull request?

We can take it directly, but I'm not picking up patches until after
the final 4 branches have been sent up and merged.



-Olof
