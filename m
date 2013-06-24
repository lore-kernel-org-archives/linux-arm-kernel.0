From: arno@natisbad.org (Arnaud Ebalard)
Date: Mon, 24 Jun 2013 23:31:28 +0200
Subject: [BUG] mv64xxx i2c bus lock w/ commit eda6bee6c7
In-Reply-To: <20130624183006.GA3129@katana> (Wolfram Sang's message of "Mon,
 24 Jun 2013 20:30:07 +0200")
References: <87a9mkttxr.fsf@natisbad.org> <20130623153931.GD7626@kw.sim.vm.gnt>
 <20130623160659.GB17536@roeck-us.net> <87fvw8ehne.fsf@natisbad.org>
 <20130624183006.GA3129@katana>
Message-ID: <87wqpjkxfz.fsf@natisbad.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Wolfram Sang <wsa@the-dreams.de> writes:

>> does nothing fancy either. While debugging I ended up on Debian bug
>> #622325 (http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=622325) which
>> made the driver a little less suspect when a revert of commit eda6bee6c7
>> fixed the issue for me.
>
> Either wait for 3.11 or pick 4243fa0bad551b8c8d4ff7104e8fd557ae848845
> "(I2C: mv64xxx: fix race between FSM/interrupt and process context")
> from my for-next branch. (Note the other patches from Russell, probably
> all worth to pick).

Thanks for the tip. Will try it tomorrow.

> Would be nice if you could pass the info to the Debian bug as well.

I will.

Cheers,

a+
