From: timur@tabi.org (Timur Tabi)
Date: Sun, 28 Aug 2016 15:36:11 -0500
Subject: ARM, SoC: About the use DT-defined properties by 3rd-party drivers
In-Reply-To: <57BDAF2E.10502@laposte.net>
References: <57BDAF2E.10502@laposte.net>
Message-ID: <CAOZdJXVjsR3NTWiJX33yT3jYk=FU65raWoMooTLD7OMN3sqP-A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 24, 2016 at 9:29 AM, Sebastian Frias <sf84@laposte.net> wrote:
>
> If this is really not possible, it forces the SoC manufacturer to expose
> those properties in a different way, thus wasting a (seemingly) perfectly
> fine way of doing so: the DT and its documentation.

When you submit a new driver upstream, that patch also includes the
new device tree nodes and documentation for those nodes.  Everything
is peer-reviewed together.  I don't understand what you think the
problem is.
