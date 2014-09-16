From: naobsd@gmail.com (Naoki FUKAUMI)
Date: Tue, 16 Sep 2014 14:23:44 +0900
Subject: [PATCH 08/11] ARM: dts: rockchip: add operating points and armclk
 references
In-Reply-To: <54179614.7040707@rock-chips.com>
References: <1409958374-30937-1-git-send-email-heiko@sntech.de>
 <1409958374-30937-9-git-send-email-heiko@sntech.de>
 <CAD=FV=U0h2nDQf6JzErhUn+R7384xSTeTjga03MZtOccf7S0bg@mail.gmail.com>
 <5412A1E3.1090707@rock-chips.com>
 <CAFnsNoRdW8icUsuEhMq4YB6wi0njoxu3Vvjv6USKTKec_bJwPg@mail.gmail.com>
 <54179614.7040707@rock-chips.com>
Message-ID: <CAFnsNoQJhvse5pY2GNR7gXCrHsQeat5bN0gtRfTL0myMfABXDw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Sep 16, 2014 at 10:44 AM, Kever Yang <kever.yang@rock-chips.com> wrote:
>> This commit says 1800000 is safe, but actually it's not safe?
>>
>> https://bitbucket.org/T-Firefly/firefly-rk3288/commits/7048675eec554a1aa4a3874c7bb24806e1e1c06b/raw/
>
> As you have seen, that patch is for a dts file which is board related
> instead of rk3288.dtsi,
> it should be safe for T-firefly board, but I'm not sure it works for all the
> boards.
>
> The operation table I provide for rk3288.dtsi with conservative values and
> available for all boards
> based on rk3288, and maybe need an OPP table with optimized values in dts
> board file
> for board customized.

I see, thank you so much.
sorry for the noise.
