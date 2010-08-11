From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 11 Aug 2010 16:05:40 +0200
Subject: Query: Patches break with Microsoft exchange server.
In-Reply-To: <1281389338.7143.32.camel@localhost>
References: <4C5F9B25.8080401@st.com>
	<201008091735.11105.mihai.dontu@gmail.com>
	<4C6040FC.2020702@gmail.com>
	<201008092115.25992.mihai.dontu@gmail.com>
	<1281389338.7143.32.camel@localhost>
Message-ID: <AANLkTikQWj=Vx7T_+SjqRS3GTDgHQ6x2zn_MgcCUTj9M@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 9, 2010 at 23:28, David Woodhouse <dwmw2@infradead.org> wrote:
> On Mon, 2010-08-09 at 21:15 +0300, Mihai Don?u wrote:
>>
>> Wait. I don't think we're on the same page here. I'm talking about message
>> signing (which does not require the receiving end to have any key - it's the
>> same plain text e-mail with a blob after it) while you refer to actually
>> encrypting the message. Mm? Or am I being extremely slow today? :-)
>
> Only when you assume that Exchange would pass signed messages without
> corrupting them. It really is that broken.

Indeed. In my experience Exchange may
  - corrupt PGP signed email, causing the signature verification to fail,
  - send/forward all email in BASE64, causing it to be dropped by
vger.kernel.org.

Gr{oetje,eeting}s,

? ? ? ? ? ? ? ? ? ? ? ? Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
? ? ? ? ? ? ? ? ? ? ? ? ? ?? ?? -- Linus Torvalds
