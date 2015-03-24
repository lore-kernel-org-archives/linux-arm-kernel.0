From: jhautbois@gmail.com (Jean-Michel Hautbois)
Date: Tue, 24 Mar 2015 16:27:30 +0100
Subject: [PATCH 0/5] ARM: imx: ventana: enable LDO-bypass mode
In-Reply-To: <CAJ+vNU3-Q2LkGDau1c6rXTaGkP9c3-RC-OuHiTvv=DETKvnDaw@mail.gmail.com>
References: <1414729631-11005-1-git-send-email-tharvey@gateworks.com>
 <CAL8zT=jB1M19WRA4y2q0zHG6zggm=TFHrxNOD0=hgX-o726kNg@mail.gmail.com>
 <CAJ+vNU3-Q2LkGDau1c6rXTaGkP9c3-RC-OuHiTvv=DETKvnDaw@mail.gmail.com>
Message-ID: <CAL8zT=hTVSKAgHaDeG2_Q1Y0hdJVBDmbbbQaXZ0Lms2sKaC4tQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tim,

2015-03-24 16:11 GMT+01:00 Tim Harvey <tharvey@gateworks.com>:
> On Tue, Feb 24, 2015 at 1:36 PM, Jean-Michel Hautbois
> <jhautbois@gmail.com> wrote:
>> Hi Tim,
>>
>> 2014-10-31 5:27 GMT+01:00 Tim Harvey <tharvey@gateworks.com>:
>>> The IMX6 has some internal LDO regulators provided by the anatop regulator
>>> block that can regulate the arm, soc, gpu/vpu core supplies. Alternatively a
>>> design can supply vdd_arm and vdd_soc externally via a PMIC to provide a lower
>>> power draw (switches are more efficient that ldo's).
>>
>> What is the status of these patches ? My design uses a PFUZE100
>> regulator, and having this would be interesting.
>>
>> Thanks,
>> JM
>
> JM,
>
> No update from me - I haven't had time to get back to this
> unfortunately. Most of our customers are using the Freescale vendor
> kernel and I have ldo-bypass working fine there, just not in a way
> that is easily mainlineable without work.


OK, thank you...
It's ashame that Freescale won't do a proper job to mainline
everything, it would be good for them too !
Well, If I get some time to look into this I will probably start from
your proposal.

Thanks,
JM
