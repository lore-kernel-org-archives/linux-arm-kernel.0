From: maxime.hadjinlian@gmail.com (Maxime Hadjinlian)
Date: Mon, 23 Dec 2013 17:04:14 +0100
Subject: [PATCH 1/2] ARM: Kirkwood: Add 6192 DTSI file
In-Reply-To: <20131223155618.GA7746@lunn.ch>
References: <1387813346-16741-1-git-send-email-maxime.hadjinlian@gmail.com>
 <20131223155618.GA7746@lunn.ch>
Message-ID: <CAGduivxrmuCgzMGkthY6QsET1fDqB0VzpUrZ6=GpBSt0FdDJ=A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 23, 2013 at 4:56 PM, Andrew Lunn <andrew@lunn.ch> wrote:
> On Mon, Dec 23, 2013 at 04:42:25PM +0100, Maxime Hadjinlian wrote:
>> This file is mainly a copy of kirkwood-6281.dtsi.
>> The pinctrl seems to be the same.
>> These platforms differs only with their CPU, memory capabilities and the
>> number of GPIO available (36 on 6192, 50 on 6281).
>>
>> Signed-off-by: Maxime Hadjinlian <maxime.hadjinlian@gmail.com>
>> ---
>>  arch/arm/boot/dts/kirkwood-6192.dtsi | 107 +++++++++++++++++++++++++++++++++++
>>  1 file changed, 107 insertions(+)
>>  create mode 100644 arch/arm/boot/dts/kirkwood-6192.dtsi
>
> Hi Maxime
Hi Andrew
>
> Jason recently sorted both 6181 and 6182. It would be nice if this
> file also used the same order. Take a look Jason's DT branch.
Sure thing, could you please give a link to Jason's branch ?
>
> Thanks
>      Andrew
