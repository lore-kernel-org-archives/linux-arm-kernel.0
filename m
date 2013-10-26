From: arno@natisbad.org (Arnaud Ebalard)
Date: Sun, 27 Oct 2013 00:58:16 +0200
Subject: Subsystem/interface for a 16x2 character LCD driver?
In-Reply-To: <20131026221103.GD28577@1wt.eu> (Willy Tarreau's message of "Sun,
 27 Oct 2013 00:11:03 +0200")
References: <87iowjrblq.fsf@natisbad.org> <20131026221103.GD28577@1wt.eu>
Message-ID: <874n83r65z.fsf@natisbad.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi WIlly,

Willy Tarreau <w@1wt.eu> writes:

>> If you have any idea where/who I can ask, do not hesitate. Additionally,
>> if someone has thoughts on what the DT interface should look like for
>> such a device, I am interested.
>
> You should probably take a look at the "panel" driver in staging. It's
> a driver I wrote 10-15 years ago and that someone submitted. It supports
> most 2-line text LCD panels with various wirings (serial/parallel), and
> relies on parport to drive them. You can probably reuse some/most of it
> for your driver. You may also possibly add a new backend to it to access
> GPIOs. Userland drives it by writing into /dev/lcd. I don't know if that
> can help.

Will take a look. Thanks.

Cheers,

a+
