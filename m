From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 15 Aug 2016 13:07:57 -0300
Subject: [PATCH 3/3] ARM: dts: imx28: Fix build warnings with W=1
In-Reply-To: <CAL_Jsq+u7c3Tj+AyuXhNhME8uZvJmX2a8EJmHow6Tkd1vv=7nA@mail.gmail.com>
References: <1471203266-30414-1-git-send-email-festevam@gmail.com>
 <1471203266-30414-3-git-send-email-festevam@gmail.com>
 <CAL_Jsq+u7c3Tj+AyuXhNhME8uZvJmX2a8EJmHow6Tkd1vv=7nA@mail.gmail.com>
Message-ID: <CAOMZO5CjBye7=a4AnYCJ1HDC42F6wW331XXNx+11tAdxX9Edmg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 15, 2016 at 1:01 PM, Rob Herring <robh+dt@kernel.org> wrote:
> On Sun, Aug 14, 2016 at 2:34 PM, Fabio Estevam <festevam@gmail.com> wrote:
>> From: Fabio Estevam <fabio.estevam@nxp.com>
>>
>> Fix the following build warnings with W=1:
>>
>> Warning (unit_address_vs_reg): Node /memory has a reg or ranges property, but no unit name
>>
>> While at it, also pass the 'device_type' property as recommended by the
>> ePAPR specification.
>
> I'm surprised it worked without unless you were relying on
> skeleton.dtsi. If that's the case, please remove the dependency on
> skeleton.dtsi while at it.

Yes, imx28.dtsi includes skeleton.dtsi. Will remove this dependency
and submit a v2.
