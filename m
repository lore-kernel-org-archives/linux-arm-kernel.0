From: fijam@archlinux.us (JM)
Date: Wed, 21 Oct 2015 23:28:58 +0200
Subject: I/O issues with writing to mtdblock devices on kirkwood
In-Reply-To: <5628022A.9050707@mcfarlanes.me>
References: <1444722697.16876.55.camel@debian.org>
 <5626B4DC.8000407@mcfarlanes.me>
 <5627F4E8.3030907@mcfarlanes.me> <1445461864.32735.21.camel@debian.org>
 <5628022A.9050707@mcfarlanes.me>
Message-ID: <CAKzmTe2Z2hOTuHYcXx9HUjJbri1Tm9qwye-rxxsWNxrsjGqp+w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 21, 2015 at 11:22 PM, Iain McFarlane <iain@mcfarlanes.me> wrote:
> On a different note anyone know why udev would not be running modprobe?
> Every time I reboot this box I have to the reload any of the modules not
> specified in the initrd even things like mvmdio to get the network working.
>

If you see something like ' kmod_search_moddep() could not open moddep
file' in your logs, you need to run depmod -a manually.

I've had it happen once for not entirely clear reasons, but probably
related to the interrupted kernel package installation.

HTH,
Jan

PS Now we have Ian, Iain and Jan posting in this thread.
