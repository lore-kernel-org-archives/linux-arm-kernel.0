From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Mon, 12 Feb 2018 12:47:45 +0100
Subject: [PATCH v2 3/3] ARM: dts: exynos: Add support for HDMI audio on
 exynos5433-tm2
In-Reply-To: <CAJKOXPfXR3pRcTy_y2jwg7R8Pkg15+VJyOvCaXvQa8ZHS=HeBA@mail.gmail.com>
References: <CGME20180208184446epcas2p2a5a59112f29b97dad9deb820699eb741@epcas2p2.samsung.com>
 <20180208184408.24185-1-s.nawrocki@samsung.com>
 <20180208184408.24185-3-s.nawrocki@samsung.com>
 <CAJKOXPfXR3pRcTy_y2jwg7R8Pkg15+VJyOvCaXvQa8ZHS=HeBA@mail.gmail.com>
Message-ID: <c40f9d95-cf7d-c505-ab56-55b475efe136@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/12/2018 10:28 AM, Krzysztof Kozlowski wrote:
>> +&i2s1 {
>> +       assigned-clocks = <&i2s1 CLK_I2S_RCLK_SRC>;
>> +       assigned-clock-parents = <&cmu_peric CLK_SCLK_I2S1>;
>
> Reorder alphabetically the node (and then you'll see you already add
> one for i2s1).

Oops, my fault, let me correct this again and resend.

-- 
Regards,
Sylwester
