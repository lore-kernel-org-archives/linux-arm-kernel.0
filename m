From: olof@lixom.net (Olof Johansson)
Date: Mon, 10 Oct 2011 11:11:20 -0700
Subject: [PATCH v2 10/14] ARM: tegra: tegra_powergate_is_powered should be
	static
In-Reply-To: <4E92CC72.3030809@ru.mvista.com>
References: <1317956064-17650-1-git-send-email-olof@lixom.net>
	<1318224484-2090-1-git-send-email-olof@lixom.net>
	<1318224484-2090-11-git-send-email-olof@lixom.net>
	<4E92CC72.3030809@ru.mvista.com>
Message-ID: <CAOesGMj2q0RjQOKu7hSc=Mhom2u3M2zwcXCMqjcsfgEB2tNKGg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Oct 10, 2011 at 3:44 AM, Sergei Shtylyov
<sshtylyov@ru.mvista.com> wrote:
> Hello.
>
> On 10-10-2011 9:28, Olof Johansson wrote:
>
>> Not exported and not used externally.
>
>> Also, fix return type ?and change to instead WARN_ON on bad parameters.
>
> ? Change to what? You're changing _to_ WARN_ON() as we can see, not from
> it...

I guess I wasn't entirely clear in the commit message, thanks for
pointing it out.

I revised the text just now when I applied the series -- not really
warranting a repost of the patch though.


Thanks,

-Olof
