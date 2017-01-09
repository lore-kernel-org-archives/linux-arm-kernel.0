From: bjsprakash.linux@gmail.com (Prakash B)
Date: Mon, 9 Jan 2017 11:45:28 +0530
Subject: [PATCH v3] arm64: mm: Fix NOMAP page initialization
In-Reply-To: <4fbd559b-b4f2-2c89-3024-5d1137ff170d@linaro.org>
References: <20161216165437.21612-1-rrichter@cavium.com>
 <CAKv+Gu_SmTNguC=tSCwYOL2kx-DogLvSYRZc56eGP=JhdrUOsA@mail.gmail.com>
 <c74d6ec6-16ba-dccc-3b0d-a8bedcb46dc5@linaro.org>
 <cbbf14fd-a1cc-2463-ba67-acd6d61e9db1@linaro.org>
 <CACJhumfqWkXXpbJomjJ1jM5B3kG+1Jk9EvGWR50_u-AO1ySXfg@mail.gmail.com>
 <4fbd559b-b4f2-2c89-3024-5d1137ff170d@linaro.org>
Message-ID: <CACJhumf4Ej4m5oPeVp1uKiYgk8LO-1W2L+ExhH6hti+yJXXnqA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks Hanjun ,


On Mon, Jan 9, 2017 at 10:39 AM, Hanjun Guo <hanjun.guo@linaro.org> wrote:
> Hi Prakash,
> I didn't test "cpuset01" on D05 but according to the test in
> Linaro, LTP full test is passed on D05 with Ard's 2 patches.
>
>>
>> Any idea what might be causing this issue.
>
>
> Since it's not happening on D05, maybe it's related to
> the firmware? (just a wild guess...)
>

 Used same firmware b/w 4.4 kernel and 4.9 (and   above kernels) .
Test passed wtih 4.4 kernel and didn't generated  any crashes or
dumps.

If there is more observation I will  send a  mail  or I will start a
separate mail thread.

Thanks,
Prakash B
