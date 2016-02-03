From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 3 Feb 2016 12:38:25 -0200
Subject: SGTL5000 misc
In-Reply-To: <CAEuupiszxAj7JkJu-5ozqgEnTWkz9FQEpxN8dmEN+KtaV-76ww@mail.gmail.com>
References: <CAEuupiuhPR48Upo=8f0zV8cxf0Vefgx3qA+vC+QDWAOV4n-e3Q@mail.gmail.com>
 <CAOMZO5BPNc1ncz6J8yhcBYywCVuTxKYMYhiNUt_Jq3LZsKdi+A@mail.gmail.com>
 <CAEuupiszxAj7JkJu-5ozqgEnTWkz9FQEpxN8dmEN+KtaV-76ww@mail.gmail.com>
Message-ID: <CAOMZO5DhrzdVyTVPB3FNquV4rDQ8a0MQrsJMosVsUQN63hj1Ww@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 3, 2016 at 12:33 PM, Erik Friesen <friesendrywall@gmail.com> wrote:
> [    0.000000] Linux version 3.10.53-gf3f6648-dirty (root at friesen-nas)

That's a very old kernel. You should try something newer like 4.4.

We had issues with sgtl5000 codec that were fixed with this commit:
https://git.kernel.org/cgit/linux/kernel/git/stable/linux-stable.git/commit/sound/soc/codecs/sgtl5000.c?id=af8ee11209e749c75eabf32b2a4ca631f396acf8

> Its a bit unclear here, am I supposed to reply only to
> linux-arm-kernel at list.infraread.org?

It is fine to reply to all.
