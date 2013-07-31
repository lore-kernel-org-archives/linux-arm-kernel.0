From: kevin.z.m.zh@gmail.com (kevin.z.m)
Date: Wed, 31 Jul 2013 20:10:32 +0800
Subject: [PATCH 4/4] ARM: sun6i: Enable clock support in the DTSI
References: <1375195462-19566-1-git-send-email-maxime.ripard@free-electrons.com>
 <1375195462-19566-5-git-send-email-maxime.ripard@free-electrons.com>
 <51F86A2E.10505@elopez.com.ar> <20130731073724.GA24439@lukather>
 <2013073116110750016327@gmail.com>,
 <20130731114957.GD2911@lukather>
Message-ID: <2013073120102496855035@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi, Maxime,

> How does one select either the internal or the external 32kHz
> oscillator? Is this done in software (I can't find any reference to that
> in the user manuals) or in hardware?
For A20, it should be in the Timer module, and there is a register named "LOSC_CTRL_REG".
For A31, it is in the RTC module, same name of "LOSC_CTRL_REG".


Best Regards, 
kevin.z.m
