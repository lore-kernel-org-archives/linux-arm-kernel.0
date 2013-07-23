From: olof@lixom.net (Olof Johansson)
Date: Tue, 23 Jul 2013 11:03:05 -0700
Subject: [PATCH linux-next] arm: zynq: fix compilation warning
In-Reply-To: <20130628103855.c4a89a6f1c6ef425fee34bc6@canb.auug.org.au>
References: <1372336962-6459-1-git-send-email-vincent.stehle@freescale.com>
 <51CC37BF.8030309@monstr.eu>
 <20130628103855.c4a89a6f1c6ef425fee34bc6@canb.auug.org.au>
Message-ID: <CAOesGMgCDb=YUdNsmNw7GfnnQM0F1C2r18h0orW8Zf4-nFWT1w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 27, 2013 at 5:38 PM, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> On Thu, 27 Jun 2013 15:01:51 +0200 Michal Simek <monstr@monstr.eu> wrote:
>>
>> Arnd asked in this post
>> http://www.mail-archive.com/linux-kernel at vger.kernel.org/msg454947.html
>> to fold his small patch to that larger one.
>>
>> Not sure why it is not there.
>> Arnd, Robin?
>
> Should have asked Andrew :-)
>
> I have added (most of) Arnd's patch to the end of the akpm tree today.

It was a dependency thing where new code was added in arm-soc, so the
sweeping patches in Andrew's tree couldn't cover them (without adding
said dependency and thus no longer apply on top of mainline).

I'll apply this and the keystone fix to the arm-soc fixes branch now
for 3.11-rc3.


-Olof
