From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 24 Mar 2017 23:25:50 +0100
Subject: [GIT PULL 1/4] bcm2835 arm DT updates for 4.12
In-Reply-To: <20170321193952.10270-1-eric@anholt.net>
References: <20170321193952.10270-1-eric@anholt.net>
Message-ID: <CAK8P3a2X0LYeidiPw4xN07WdU86Ah3_nJeropNSieJWxsHoEmA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 21, 2017 at 8:39 PM, Eric Anholt <eric@anholt.net> wrote:
>   Linux 4.11-rc1 (2017-03-05 12:59:56 -0800)
>
> are available in the git repository at:
>
>   git://github.com/anholt/linux tags/bcm2835-dt-next-2017-03-21
>
> for you to fetch changes up to 7f31a955a0c34de0463f7ff50b2bd62a5cce4204:
>
>   ARM: dts: bcm2835: add sdhost controller to devicetree (2017-03-17 17:35:50 -0700)
>
> ----------------------------------------------------------------
> This pull request brings in the DT nodes for enabling HDMI audio on
> Raspberry Pi, and nodes to describe the DSI and SDHOST hardware
> modules (which are still disabled by default).

Just a quick question: how do you plan to switch between the SD host
drivers? If I understand this right, there are two working hardware blocks
that can connect to the same slot. Do you have to configure this in
device tree using  hardwired pinctrl settings, or can the user pick
one of the drivers at runtime?

        Arnd
