From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Tue, 19 Sep 2017 08:00:10 +1000
Subject: Linux-next broken for 2 weeks was Re: n900 in next-20170901
In-Reply-To: <20170918081109.GA11661@amd>
References: <20170903203737.GA12475@amd> <20170905201314.GE5024@atomide.com>
 <20170905233241.GA19231@js1304-P5Q-DELUXE>
 <20170906133057.GH5024@atomide.com>
 <20170907073038.GA2111@js1304-P5Q-DELUXE>
 <20170907161650.GP5024@atomide.com> <20170915131817.GA19486@amd>
 <20170918020126.GA19200@js1304-P5Q-DELUXE>
 <20170918081109.GA11661@amd>
Message-ID: <20170919080000.59a79ba2@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Pavel,

On Mon, 18 Sep 2017 10:11:09 +0200 Pavel Machek <pavel@ucw.cz> wrote:
>
> Unfortunately, rest of the world can reproduce the error, and it means
> linux-next is useless for us.
> 
> I'd expect you to drop the relevant tree from linux-next when the
> error was reported. Clearly, those patches are unsuitable for 4.15, as
> they are broken, so they should not be in linux-next.

Andrew has asked me to drop the patches from linux-next today and I
have done so.

-- 
Cheers,
Stephen Rothwell
