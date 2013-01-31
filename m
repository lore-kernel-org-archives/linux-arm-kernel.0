From: iwamatsu@nigauri.org (Nobuhiro Iwamatsu)
Date: Thu, 31 Jan 2013 10:19:44 +0900
Subject: [PATCH v2 1/3] arm: mvebu: Add support for USB host controllers
 in Armada 370/XP
In-Reply-To: <CALF0-+Vg1WZA3m9G7mLU92BBuDpGLG-pmMM=XHtGm2UwnXXLUw@mail.gmail.com>
References: <1358954792-16160-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <CALF0-+W8dVLHF66VKni+5ZsQpFd=cGDXE0TD=dRc1B=ptrAMUg@mail.gmail.com>
 <20130123174025.GV1758@titan.lakedaemon.net>
 <CALF0-+Vg1WZA3m9G7mLU92BBuDpGLG-pmMM=XHtGm2UwnXXLUw@mail.gmail.com>
Message-ID: <CABMQnVKxiDwXvweLa7jdAw5q2bH9cj-HDfPoijadVkren52JNg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Ezequiel.

I checked with your first patch, that is no ploblem.
you dont need to change patch.
sorry for my noise.

best regards,
  Nobuhiro

On Wed, Jan 30, 2013 at 3:56 AM, Ezequiel Garcia <elezegarcia@gmail.com> wrote:
> Hi Jason,
>
> On Wed, Jan 23, 2013 at 2:40 PM, Jason Cooper <jason@lakedaemon.net> wrote:
>> On Wed, Jan 23, 2013 at 02:06:12PM -0300, Ezequiel Garcia wrote:
>>> Jason,
>>>
>>> On Wed, Jan 23, 2013 at 12:26 PM, Ezequiel Garcia <ezequiel.garcia@free-electrons.com> wrote:
>>> > The Armada 370 and Armada XP SoC has an Orion EHCI USB controller.
>>> > This patch adds support for this controller in Armada 370
>>> > and Armada XP SoC common device tree files.
>>> >
>>> > Cc: Lior Amsalem <alior@marvell.com>
>>> > Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
>>> > Tested-by: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
>>> > Tested-by: Florian Fainelli <florian@openwrt.org>
>>> > Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
>>> > Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
>>> > ---
>>> > Changes from v1:
>>> >  * Remove uneeded USB_ARCH_HAS_EHCI selection as noted by Florian.
>>> >
>>> >  arch/arm/boot/dts/armada-370-xp.dtsi |   15 +++++++++++++++
>>> >  arch/arm/boot/dts/armada-370.dtsi    |    9 +++++++++
>>> >  arch/arm/boot/dts/armada-xp.dtsi     |   17 +++++++++++++++++
>>> >  3 files changed, 41 insertions(+), 0 deletions(-)
>>>
>>> Do you think we're still in time to get this series into v3.9 (given
>>> we decide soon on the OpenBlocks issue)?
>>
>> That shouldn't be a problem.
>>
>
> Do you think we can take this series for v3.9 as it is?
> I have no problems making any changes if they are needed
> but I can't move forward with the OpenBlocks issue since
> I don't have access to the hardware.
>
> I think we can sanely merge this as it is, since it has been tested in
> every platform.
> If there's anything to change we can do it later, when I have more
> information about the
> OpenBlocks hardware.
>
> Thanks,
>
> --
>     Ezequiel



-- 
Nobuhiro Iwamatsu
   iwamatsu at {nigauri.org / debian.org}
   GPG ID: 40AD1FA6
