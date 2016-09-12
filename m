From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 12 Sep 2016 18:06:05 +0100
Subject: ARM, SoC: About the use DT-defined properties by 3rd-party drivers
In-Reply-To: <CANCZdfqZEMRaFqgph6kZPdyxBcURBiEV0XoH0vPG28Hhm5+77A@mail.gmail.com>
References: <57BDAF2E.10502@laposte.net>
 <CAOZdJXVjsR3NTWiJX33yT3jYk=FU65raWoMooTLD7OMN3sqP-A@mail.gmail.com>
 <57D69FB1.2020801@laposte.net> <20160912123809.GB13741@leverpostej>
 <57D6AA54.6000208@laposte.net> <20160912135549.GA14165@leverpostej>
 <CANCZdfri+T59FA4XTaH5JbW0BaJHt3w5eaSkpD8NrJn6nZrZbA@mail.gmail.com>
 <57D6D7D2.7030507@laposte.net>
 <CANCZdfqZEMRaFqgph6kZPdyxBcURBiEV0XoH0vPG28Hhm5+77A@mail.gmail.com>
Message-ID: <20160912170604.GG14165@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Sep 12, 2016 at 10:45:37AM -0600, Warner Losh wrote:
> Do I have more examples where FreeBSD has to deviate because the DT is
> actually Linux specific and does a poor job of modeling the hardware
> and instead reflects the Linux driver model? I have plenty of those...

I guess you don't actually have those written down, but on the
off-chance, would you be able to share any major pain points?

We do try (admittedly far from perfectly) to avoid implementation
details in bindings, but driver mdoel details are fairly difficult to
pin down either way. It would be nice to be more aware.

Thanks,
Mark.
