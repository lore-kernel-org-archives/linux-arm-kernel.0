From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 30 May 2014 21:56:44 +0200
Subject: [E1000-devel] ARM support for igb driver
In-Reply-To: <CAHH3p5KS9BVb-1-u2LbfLL8OO4pmExGmCtZY=fEYELS+q=grcA@mail.gmail.com>
References: <CAHH3p5KAwyMOY=ai_h0eM+JwYLtTO8d4jVaVOWVtOakhqPRTew@mail.gmail.com>
 <20140530191852.GA25314@obsidianresearch.com>
 <CAHH3p5KS9BVb-1-u2LbfLL8OO4pmExGmCtZY=fEYELS+q=grcA@mail.gmail.com>
Message-ID: <4627439.I2CpBecnJJ@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 31 May 2014 01:05:29 shiv prakash Agarwal wrote:
> Thanks Jason,
> 
> Is there a way to disable sending VDM by Intel card?
> And what is the purpose of sending type 1 VDM if it has to be
> discarded by root port anyway?

I think you should really just disable the behavior at the root port.
Which host driver are you using (sorry if I forgot and you already mentioned
it)?

	Arnd
