From: pku.leo@gmail.com (Leo Li)
Date: Wed, 7 Sep 2016 11:40:32 -0500
Subject: [PATCH v5] i2c: imx: make bus recovery through pinctrl optional
In-Reply-To: <CAChUvXMPDZB7=ZArQ5+6ae42N=Bsgv_OczGXnyhBjEdjt_yvsw@mail.gmail.com>
References: <1471644322-22670-1-git-send-email-leoyang.li@nxp.com>
 <20160906185849.27pjhawadca5pwow@pengutronix.de>
 <CADRPPNQ+1qBNL5WA=Jo_keE7BPnoOs7a2T6CpTuciiF16qK6xQ@mail.gmail.com>
 <87ca69fb85848a0a86b34a9a9037a57b@agner.ch>
 <CADRPPNSPye45bmFshfwb+gDA0x0ygs4Ofa6HMYbKt9ER0oeccg@mail.gmail.com>
 <CAChUvXOGjTn6K5588UVgjbRWUY+weDtk2qbOU-NM4=kA2znh=Q@mail.gmail.com>
 <20160907055547.opp57zyxhlplhxhm@pengutronix.de>
 <CAChUvXMPDZB7=ZArQ5+6ae42N=Bsgv_OczGXnyhBjEdjt_yvsw@mail.gmail.com>
Message-ID: <CADRPPNRppCf4v7S_i69XOmY8X6YwUeiwdkaRZwSDaao5XHKChQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 7, 2016 at 5:07 AM, Tracy Smith <tlsmith3777@gmail.com> wrote:
> Hello, bus recovery is needed generally speaking because of potential
> protocol errors that might cause a failure condition hanging the bus.
>
> It happens frequently during bring-up of new I2C devices because firmware in
> I2C controllers fail to handle properly protocol errors.
>
> Can NXP add bus recovery for the LS1021A and LS1043A in a separate patch--
> unless there is no HW bus recovery mechanism?
>
> The concern is while fixing I.MX, NXP will fail to fix the driver bus
> recovery for the LS1021A and LS1043A and the bus will hang.
>
> If bus recovery is supported on the LS1021A and the LS1043A, a patch should
> be provided or added in this patch instead of simply disabling bus recovery.
> Request NXP to consider the patch if there is HW support for bus recovery.

I'm not the right person to answer if this is possible.  I will
forward your request to the related developer.

Thanks,
Leo
