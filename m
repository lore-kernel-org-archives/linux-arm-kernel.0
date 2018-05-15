From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 15 May 2018 13:57:43 -0300
Subject: [PATCH] ARM: dts: imx28-tx28: Fix alias DTC warnings
In-Reply-To: <20180515064234.GJ26863@dragon>
References: <1525693192-3579-1-git-send-email-festevam@gmail.com>
 <20180515064234.GJ26863@dragon>
Message-ID: <CAOMZO5ATmS7_7m6eDOpLr-J7AoWUH8uyttWuaASMGWwqWgfX8w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 15, 2018 at 3:42 AM, Shawn Guo <shawnguo@kernel.org> wrote:

>> -     spi_gpio: spi-gpio {
>> +     spi_gpio: spi {
>
> Not sure why the node name needs to be changed here.

Yes, this is a different fix and should be part of a different patch.
