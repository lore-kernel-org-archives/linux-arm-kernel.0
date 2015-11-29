From: vishnupatekar0510@gmail.com (Vishnu Patekar)
Date: Sun, 29 Nov 2015 20:02:44 +0800
Subject: [PATCH v2 1/3] ARM: sunxi: Introduce Allwinner for A83T support
In-Reply-To: <CAGb2v645Bwzdc1Uq0sR9SWqQH4htiO6qyPs28Hc5iOiJffXDHQ@mail.gmail.com>
References: <1445557577-27383-1-git-send-email-vishnupatekar0510@gmail.com>
 <1445557577-27383-2-git-send-email-vishnupatekar0510@gmail.com>
 <CAGb2v645Bwzdc1Uq0sR9SWqQH4htiO6qyPs28Hc5iOiJffXDHQ@mail.gmail.com>
Message-ID: <CAEzqOZuRPcwcv2=Ni82GMyYnTnKHrZWtk3QOZZBQC5KYkd3J8w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,
Sorry for delayed response.

On Fri, Oct 23, 2015 at 9:37 AM, Chen-Yu Tsai <wens@csie.org> wrote:
> On Fri, Oct 23, 2015 at 7:46 AM, Vishnu Patekar
> <vishnupatekar0510@gmail.com> wrote:
>> Allwinner A83T is octa-core cortex-a7 based SoC.
>> It's clock control unit and prcm, pinmux are different from previous sun8i
>> series.
>> Its processor cores are arragned in two clusters 4 cores each,
>> similar to A80.
>>
>> Signed-off-by: Vishnu Patekar <vishnupatekar0510@gmail.com>
>
> Could you also update Documentation/arm/sunxi/README, so it says A83T
> is supported?
I'll update and send next version.
>
> Otherwise,
>
> Acked-by: Chen-Yu Tsai <wens@csie.org>
