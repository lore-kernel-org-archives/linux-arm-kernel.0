From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 9 Apr 2018 10:24:41 +0200
Subject: [PATCH v5 07/13] ARM: smp: Add initialization of CNTVOFF
In-Reply-To: <86vad7qc21.wl-marc.zyngier@arm.com>
References: <20180403061836.3926-1-mylene.josserand@bootlin.com>
 <20180403061836.3926-8-mylene.josserand@bootlin.com>
 <06308f46-ce7c-ddeb-ebca-abd1153138ba@arm.com>
 <20180404155909.148085f7@dell-desktop.home>
 <86vad7qc21.wl-marc.zyngier@arm.com>
Message-ID: <CAMuHMdUoUVF+WYrPG1Dx515_de_2nhGhLfn9+tJUm5jgs1uz0w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 4, 2018 at 4:30 PM, Marc Zyngier <marc.zyngier@arm.com> wrote:
> On Wed, 04 Apr 2018 14:59:09 +0100,
> Myl?ne Josserand wrote:

[Marc: stuck in ISO-8859-1? ;-]

>> > It'd be good to take this opportunity to refactor the shmobile code.
>>
>> I can do it in this series but I do not have any shmobile platforms so
>> I will not be able to test my modifications (only compilation).
>>
>> If someone can test it for me (who?), it is okay for me to refactor this
>> code :)
>
> I guess you could Cc the shmobile folks (Geert Uytterhoeven, Simon
> Horman), and get them to review/test the changes.

Correct. I can test on a remote R-Car E2 ALT board that needs it.

P.S. Interestingly, none of the Renesas CA15 SoCs seem to suffer from it,
     only CA7.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
