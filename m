From: jhautbois@gmail.com (Jean-Michel Hautbois)
Date: Tue, 24 Feb 2015 22:36:07 +0100
Subject: [PATCH 0/5] ARM: imx: ventana: enable LDO-bypass mode
In-Reply-To: <1414729631-11005-1-git-send-email-tharvey@gateworks.com>
References: <1414729631-11005-1-git-send-email-tharvey@gateworks.com>
Message-ID: <CAL8zT=jB1M19WRA4y2q0zHG6zggm=TFHrxNOD0=hgX-o726kNg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tim,

2014-10-31 5:27 GMT+01:00 Tim Harvey <tharvey@gateworks.com>:
> The IMX6 has some internal LDO regulators provided by the anatop regulator
> block that can regulate the arm, soc, gpu/vpu core supplies. Alternatively a
> design can supply vdd_arm and vdd_soc externally via a PMIC to provide a lower
> power draw (switches are more efficient that ldo's).

What is the status of these patches ? My design uses a PFUZE100
regulator, and having this would be interesting.

Thanks,
JM
