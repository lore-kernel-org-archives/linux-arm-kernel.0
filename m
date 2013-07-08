From: m.weisser.m@gmail.com (=?UTF-8?Q?Matthias_Wei=C3=9Fer?=)
Date: Mon, 8 Jul 2013 08:31:01 +0200
Subject: imx25: How to get frame buffer device in a system using device
 tree
In-Reply-To: <CAOMZO5CgAs+hR41=WdJ=jxS5gZf=opOrCXufixBh_CMP0n2TFA@mail.gmail.com>
References: <CAO8h3eFq9WhvZYbbeFfWgVEXViR8MAcGaztsvvaLpFSW-W6CfA@mail.gmail.com>
 <CAOMZO5Aat-iAN_TJ6BXEopB+WCkKgLjWh67sCXg0jd1DtzmKSQ@mail.gmail.com>
 <CAO8h3eHAfV808izZzvpPc+z6iQPr14q8OmryNs5sC+VcNk+iLg@mail.gmail.com>
 <CAOMZO5CgAs+hR41=WdJ=jxS5gZf=opOrCXufixBh_CMP0n2TFA@mail.gmail.com>
Message-ID: <CAO8h3eGhF8DRO73W9GkepUKAF-6v1EmWdMS_Gq+dA_2v5mJ2aQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabio

2013/7/5 Fabio Estevam <festevam@gmail.com>:
> Hi Matthias,
>
> On Fri, Jul 5, 2013 at 4:37 AM, Matthias Wei?er <m.weisser.m@gmail.com> wrote:
>
>> Thanks for the links. That made some things clearer for me. But I am
>> still a bit confused about the driver (imxfb.c) itself. From what I
>> can see it is not dt aware as there is no of_device_id structure with
>> the compatible entries. I think I have to add dt support to the
>> framebuffer driver. Am I right?
>
> Yes, you need to apply this one:
> http://marc.info/?l=linux-fbdev&m=136956466617736&w=2

OK. Done that and it works like a charm. Thanks a lot.

> I thought it has already been applied, but it has not reached mainline yet.
>
> Regards,
>
> Fabio Estevam

Regards
Matthias
