From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Thu, 1 Dec 2011 09:15:11 +0200
Subject: [RFC] virtio: use mandatory barriers for remote processor vdevs
In-Reply-To: <87zkfdrpn8.fsf@rustcorp.com.au>
References: <1322569886-13055-1-git-send-email-ohad@wizery.com>
 <20111129131110.GC19157@redhat.com>
 <CAK=WgbZoGYVyKt=XXvnPVdh0koSBJC0zcgkLaYRkmjwBLOFA-A@mail.gmail.com>
 <20111129151958.GA31789@redhat.com>
 <CAK=WgbZ5aBFNro3XC0cN+Ao4ZWrBHwwd3d__CSHA=n56gKmKXw@mail.gmail.com>
 <20111130145004.GD21413@redhat.com>
 <CAK=WgbY59n9N_-2_TZ9wNBNcTMV1DCrz65e-Ae=xamcg6A0dOA@mail.gmail.com>
 <20111130231306.GD30031@redhat.com> <87zkfdrpn8.fsf@rustcorp.com.au>
Message-ID: <CAK=Wgbb7kJu7WgJvCGb==7Oh_xCBrj6m2s1OH-WofXe7VgLBcA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 1, 2011 at 4:28 AM, Rusty Russell <rusty@rustcorp.com.au> wrote:
> Hmm, we got away with light barriers because we knew we were not
> *really* talking to a device. ?But now with virtio-mmio, turns out we
> are :)
>
> I'm really tempted to revert d57ed95 for 3.2, and we can revisit this
> optimization later if it proves worthwhile.

+1
