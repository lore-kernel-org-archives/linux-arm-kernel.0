From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 27 Mar 2018 15:40:33 +0200
Subject: [PATCH 1/7] ARM: multi_v7_defconfig: add OCOTP driver for NXP SoCs
In-Reply-To: <20180326073214.GB8857@dragon>
References: <20180318203442.19759-1-stefan@agner.ch>
 <20180326073214.GB8857@dragon>
Message-ID: <CAK8P3a2xhOEVF87WYCPLiw66XM1ydA9JCbf+2s4ZDApw9V5STQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 26, 2018 at 9:32 AM, Shawn Guo <shawnguo@kernel.org> wrote:
> On Sun, Mar 18, 2018 at 09:34:36PM +0100, Stefan Agner wrote:
>> Enable on-chip OTP NVMEM support for NXP i.MX and VF610 SoCs.
>> Since OTP values might be required by drivers required during
>> boot, make sure the driver is built-in (e.g. i.MX thermal
>> driver).
>>
>> Signed-off-by: Stefan Agner <stefan@agner.ch>
>
> Arnd,
>
> The series looks good to me.  In general, I keep myself away from
> multi_v7_defconfig changes, but if you expect a pull-request from me, I
> can do that.  Let me know how you want to apply the patches.

I would generally prefer that your defconfig pull requests contain changes
to both the imx specific and the generic defconfig files. It's much easier
for me to handle any conflicts when they arise during a merge than
to pick up the individual patches.

I applied all seven this time, to make sure we get them into linux-next
for more testing.

      Arnd
