From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Sun, 22 Jan 2017 17:48:25 +0100
Subject: [PATCH v3 2/9] ARM64: dts: meson-gxbb-p200: add the ethernet
 PHY's reset GPIO
In-Reply-To: <20170120174658.GG25907@lunn.ch>
References: <20170120132650.9784-1-martin.blumenstingl@googlemail.com>
 <20170120152232.13943-1-martin.blumenstingl@googlemail.com>
 <20170120152232.13943-3-martin.blumenstingl@googlemail.com>
 <20170120162138.GE25907@lunn.ch>
 <CAFBinCA47Nng_jjxKrWrV_YBHr0bg+7xPaJrVswt_WnZ6wtyjA@mail.gmail.com>
 <20170120174658.GG25907@lunn.ch>
Message-ID: <CAFBinCD+7R2cVQ-Dcr=CxRuBBFajCb-QG68ZGpza5VwprCkztQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 20, 2017 at 6:46 PM, Andrew Lunn <andrew@lunn.ch> wrote:
> On Fri, Jan 20, 2017 at 06:07:20PM +0100, Martin Blumenstingl wrote:
>> I though that this is good practice - the documentation doesn't say
>> that it should only be added in specific cases: [0]
>
> Agreed, the text should be better, listing when it is appropriate to
> use.
>
>> my intention behind adding the PHY ID was to make it easier to see
>> which devices uses which PHY. this is especially useful for devices
>> with RTL8211F PHY (basically all devices with RGMII PHY except the
>> P200) as these may need similar fixes than [1]
>
> I would not say it is wrong to list the PHY ID, it just has
> consequences if the PHY ever changes.
thanks for pointing this out again, I'll re-spin this series and
remove the PHY's "compatible" property from all patches.
I also sent a patch which hopefully makes the documentation a bit more
clear: [0]

Regards,
Martin


[0] http://marc.info/?l=linux-netdev&m=148510331812986&w=2
