From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 11 Jul 2013 09:14:30 -0300
Subject: imx25: How to get frame buffer device in a system using device
 tree
In-Reply-To: <CAO8h3eHiXroFWy2na-05MeHgfSg9LGuxMF4wkf4VwFsV57xDnw@mail.gmail.com>
References: <CAO8h3eFq9WhvZYbbeFfWgVEXViR8MAcGaztsvvaLpFSW-W6CfA@mail.gmail.com>
 <CAOMZO5Aat-iAN_TJ6BXEopB+WCkKgLjWh67sCXg0jd1DtzmKSQ@mail.gmail.com>
 <CAO8h3eHAfV808izZzvpPc+z6iQPr14q8OmryNs5sC+VcNk+iLg@mail.gmail.com>
 <CAOMZO5CgAs+hR41=WdJ=jxS5gZf=opOrCXufixBh_CMP0n2TFA@mail.gmail.com>
 <CAO8h3eGhF8DRO73W9GkepUKAF-6v1EmWdMS_Gq+dA_2v5mJ2aQ@mail.gmail.com>
 <CAOMZO5CrZjDZjqaaQTX4=ZGO_6chFMr9qAHhqyVGBdxBvimYSw@mail.gmail.com>
 <CAO8h3eHiXroFWy2na-05MeHgfSg9LGuxMF4wkf4VwFsV57xDnw@mail.gmail.com>
Message-ID: <CAOMZO5C9-o=E_jBub-YAYJ+j8ienE_-krykOm-KcjSuzq_BioQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 11, 2013 at 3:28 AM, Matthias Wei?er <m.weisser.m@gmail.com> wrote:

>> Great, care to submit patches for adding mx25 fb support?
>
> I can. But I think the only thing is the slightly changed
> arch/arm/boot/dts/imx25.dtsi. Patch to this mailing list? Patch
> against mainline kernel is OK?

Yes, you should generate the patch against Shawn's for-next branch:
http://git.linaro.org/gitweb?p=people/shawnguo/linux-2.6.git;a=shortlog;h=refs/heads/for-next

Then send the patch to him with the linux-arm-kernel list on Cc.

Regards,

Fabio Estevam
