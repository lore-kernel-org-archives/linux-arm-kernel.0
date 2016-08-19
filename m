From: heiko@sntech.de (Heiko Stuebner)
Date: Fri, 19 Aug 2016 16:16:00 +0200
Subject: [PATCH] Try to support analog audio codec at firefly reload
In-Reply-To: <1471293727-26258-1-git-send-email-ayaka@soulik.info>
References: <1471293727-26258-1-git-send-email-ayaka@soulik.info>
Message-ID: <6373888.a6VB9iqPkj@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, 16. August 2016, 04:42:06 CEST schrieb Randy Li:
> Hello:
>   This patch could enabled the es8328 codec at firefly reload board,
> but it doesn't not really work. I disable the mute of channel
> Left mix and Right mix in alsamixer, I could hear the noise from
> my headphone, but it never be a music.
>   I just send this patch here to see whether somebody could figure
> out what is wrong, I am really not familiar with sound.

I can't really help here as I have neither the board nor that much sound 
experience, but it's definitly customary to label patches as rfc when they're 
expected to need more work, so make that

[PATCH RFC] ...

for stuff that requires more work before it can actually be merged.


Heiko
