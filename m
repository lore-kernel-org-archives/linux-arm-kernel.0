From: florian.vaussard@epfl.ch (Florian Vaussard)
Date: Fri, 10 Jan 2014 08:38:25 +0100
Subject: [PATCH 06/18] ARM: dts: omap3-overo: Enable MMC2
In-Reply-To: <CABxcv=nO1ZtC7wjVSq+Qw9AmFGahpDUSjOZOO1+tYHhqo9P0Pw@mail.gmail.com>
References: <1389286092-27087-1-git-send-email-florian.vaussard@epfl.ch>	<1389286092-27087-7-git-send-email-florian.vaussard@epfl.ch>
 <CABxcv=nO1ZtC7wjVSq+Qw9AmFGahpDUSjOZOO1+tYHhqo9P0Pw@mail.gmail.com>
Message-ID: <52CFA371.8090103@epfl.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Javier,

On 01/09/2014 09:43 PM, Javier Martinez Canillas wrote:
> [adding Enric Balletbo to cc]
> 
> Hello Florian,
> 
> On Thu, Jan 9, 2014 at 1:48 PM, Florian Vaussard
> <florian.vaussard@epfl.ch> wrote:
>> MMC2 is used by the on-board WiFi module populated on some boards
>> (based on Marvell Libertas 8688 SDIO).
>>
>> Note: currently WiFi only works on cold boot, as the module is not
>> properly reset (missing binding for the GPIO reset).
>>
> 
> Have you looked at commit 0e9fd777 ("ARM: dts: omap3-igep: Add support
> for LBEE1USJYC WiFi connected to SDIO") ?
> 
> If I remember correctly the LBEE1USJYC Wifi/BT combo module is
> basically a Marvell Libertas 8688 Wlan and Enric got soft reset
> working too by adding a GPIO property to the regulator for the reset
> GPIO.
> 

Many thanks for the pointer. In the initial version, I had a regulator
like you. But now I doubt if it was correctly added to the MMC node,
which could be why it was not working... I will try again.

Thanks for your help!

Florian
