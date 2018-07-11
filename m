From: mpartap@gmx.net (Marcel Partap (unterwegs))
Date: Wed, 11 Jul 2018 12:58:35 +0200
Subject: v4.18-rc2 on droid4: screen turns red
In-Reply-To: <20180711102655.GA6864@amd>
References: <20180630131812.GA549@amd> <20180711102655.GA6864@amd>
Message-ID: <8EB5195E-E329-4001-8C1C-185D25FE6AD3@gmx.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Might this be possible to reproduce with qemu-system-arm, maybe with -icount align=off (?) to speed it up ?
Guess a bisect on the device itself would be kind of a hassle..
If I get my spare droid4 to boot again I'll send it to Prague so you can compare & see if it is somewhat deterministic ; )

Regards!
#marcel


On July 11, 2018 12:26:55 PM CEST, Pavel Machek <pavel@ucw.cz> wrote:
>Hi!
>
>> After longer inactivity, attempt to wake up the screen results in
>> screen being completely red. Not too useful. I can still connect over
>> ssh.
>
>Still there in -rc4 :-(. But happens only once in a few days for me...
>
>When X is shut down, text console works ok.

-- 
Diese Nachricht wurde von meinem Android-Mobiltelefon mit K-9 Mail gesendet.
