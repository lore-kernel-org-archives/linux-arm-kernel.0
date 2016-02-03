From: friesendrywall@gmail.com (Erik Friesen)
Date: Wed, 3 Feb 2016 09:46:31 -0500
Subject: SGTL5000 misc
In-Reply-To: <CAOMZO5DhrzdVyTVPB3FNquV4rDQ8a0MQrsJMosVsUQN63hj1Ww@mail.gmail.com>
References: <CAEuupiuhPR48Upo=8f0zV8cxf0Vefgx3qA+vC+QDWAOV4n-e3Q@mail.gmail.com>
 <CAOMZO5BPNc1ncz6J8yhcBYywCVuTxKYMYhiNUt_Jq3LZsKdi+A@mail.gmail.com>
 <CAEuupiszxAj7JkJu-5ozqgEnTWkz9FQEpxN8dmEN+KtaV-76ww@mail.gmail.com>
 <CAOMZO5DhrzdVyTVPB3FNquV4rDQ8a0MQrsJMosVsUQN63hj1Ww@mail.gmail.com>
Message-ID: <CAEuupiuoB7nMSc8Fbyort1rJd=ZhYc0zfJNkd=ckUYk1qd8Z7Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It appears sgtl5000.c is patched the same in my kernel as the commit mentioned.

The problem the way I see it, is that there is no mechanism to deal
with a reboot on the codec itself.

This alsa stuff has too many layers.  At least coming from a non os
embedded angle it seems that way.

On Wed, Feb 3, 2016 at 9:38 AM, Fabio Estevam <festevam@gmail.com> wrote:
> On Wed, Feb 3, 2016 at 12:33 PM, Erik Friesen <friesendrywall@gmail.com> wrote:
>> [    0.000000] Linux version 3.10.53-gf3f6648-dirty (root at friesen-nas)
>
> That's a very old kernel. You should try something newer like 4.4.
>
> We had issues with sgtl5000 codec that were fixed with this commit:
> https://git.kernel.org/cgit/linux/kernel/git/stable/linux-stable.git/commit/sound/soc/codecs/sgtl5000.c?id=af8ee11209e749c75eabf32b2a4ca631f396acf8
>
>> Its a bit unclear here, am I supposed to reply only to
>> linux-arm-kernel at list.infraread.org?
>
> It is fine to reply to all.
