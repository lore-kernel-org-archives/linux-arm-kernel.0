From: utx@penguin.cz (Stanislav Brabec)
Date: Sat, 16 Jan 2010 18:00:58 +0100
Subject: [suspend/resume] Re: userspace notification from module
In-Reply-To: <f17812d71001151900x35959e88jc5f275573ee02177@mail.gmail.com>
References: <686edb2c.6263643a.4b3f4a3b.b60b3@o2.pl>
	<201001091440.46434.rjw@sisk.pl>  <20100115200310.GG1345@ucw.cz>
	<201001152314.30355.rjw@sisk.pl>
	<f17812d71001151900x35959e88jc5f275573ee02177@mail.gmail.com>
Message-ID: <1263661258.6596.10.camel@utx.utx.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Eric Miao wrote:

> And the other way we may need to look into what API the current userland
> apps on zaurus is depending on this 2.4 compatibility and make changes
> slowly to those apps.

I guess that 2.4 compatibility is not an issue. Most modern Zaurus
distributions are even unable to run Sharp ROM compatible binaries.

Distributions either stay on 2.4 kernel or use modern systems based on
modern kernel 2.6 API.

Distributions that decided to migrate to kernel 2.6 are far from
finished state. Any change that allows to use modern applications using
standard kernel API is welcome.


________________________________________________________________________
Stanislav Brabec
http://www.penguin.cz/~utx/zaurus
