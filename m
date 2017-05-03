From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 3 May 2017 19:14:42 -0300
Subject: [PATCH 1/3] ARM: dts: imx6qdl-nitrogen6_max: fix rv4162 compatible
In-Reply-To: <20170503085010.GF18578@dragon>
References: <20170419202204.7689-1-alexandre.belloni@free-electrons.com>
 <20170503085010.GF18578@dragon>
Message-ID: <CAOMZO5BhxHbSyHhj-6GhHNSbgQ6H6b1+HudB9MhmUOsFPdd5YA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

On Wed, May 3, 2017 at 5:50 AM, Shawn Guo <shawnguo@kernel.org> wrote:

>>       rtc: rtc at 68 {
>> -             compatible = "st,rv4162";
>> +             compatible = "microcrystal,rv4162";
>
> The compatible is not documented?

This compatible has been added in a897bf138c9b443 ("rtc: m41t80: Add
proper compatible for rv4162") in linux-next, so it will be present in
4.12-rc1.
