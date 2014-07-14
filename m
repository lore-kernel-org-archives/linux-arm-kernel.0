From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Mon, 14 Jul 2014 11:07:37 +0530
Subject: [PATCH V9 2/7] phy: Add drivers for PCIe and SATA phy on SPEAr13xx
In-Reply-To: <CAKohpokNijH37NAmuh5cYEZxYFJE-COKwVNP3RNHSEoS03YYAA@mail.gmail.com>
References: <cover.1404976058.git.viresh.kumar@linaro.org>
 <d1ef8db8704d09ba4f276c954dc22b555998f957.1404976058.git.viresh.kumar@linaro.org>
 <53BE926A.2070005@ti.com>
 <CAKohpokNijH37NAmuh5cYEZxYFJE-COKwVNP3RNHSEoS03YYAA@mail.gmail.com>
Message-ID: <CAKohpomKjOZspU0CKuDW5kckoUqo3X-LxF5v5GGkuVMHuhi8mg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10 July 2014 19:00, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>>>  drivers/phy/phy-spear1310-miphy.c                  | 274 +++++++++++++++++++
>>>  drivers/phy/phy-spear1340-miphy.c                  | 302 +++++++++++++++++++++
>>
>> Please send separate patche for each driver.
>
> These were both around SPEAr and were on the same lines.
> So sending these in a single patch shouldn't be a big issue I believe.

For completeness I have still kept them together as they have a single
bindings file now. And breaking it out *may* affect readability later.
