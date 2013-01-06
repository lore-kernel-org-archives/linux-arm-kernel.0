From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sun, 06 Jan 2013 21:33:55 +0100
Subject: [PATCH 0/4] ALSA: pxa27x: ac97 reset fixes
In-Reply-To: <1357499640-13871-1-git-send-email-mikedunn@newsguy.com> (Mike
 Dunn's message of "Sun, 6 Jan 2013 11:13:56 -0800")
References: <1357499640-13871-1-git-send-email-mikedunn@newsguy.com>
Message-ID: <87a9smaw5o.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mike Dunn <mikedunn@newsguy.com> writes:

> AC97 reset is broken on the pxa27x.  These patches fix it by addressing multiple
> problems:
>   - cold reset fails because the GCR register is not set correctly
>   - warm reset fails because some code used to work around a hardware bug is
>     broken
>   - the intent of the work-around code is obfuscated by unfortunate function
>     naming
>
> This patch set replaces some earlier individual patches that had some problems.
> Thanks Robert and Igor.

Yes, this looks good. I'll test that one, but it does indeed look promising.
Igor, your opinion here ?

Cheers.

--
Robert
