From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Sat, 2 Dec 2017 02:05:22 +0100
Subject: [PATCH 0/2] Add devicetree for Axentia Nattis
In-Reply-To: <20171201224425.5477-1-peda@axentia.se>
References: <20171201224425.5477-1-peda@axentia.se>
Message-ID: <CABxcv=k6K8gRDSRu1r6=mELcOQLcNr6EOQGj0Q0wDXrGa58sqw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Peter,

On Fri, Dec 1, 2017 at 11:44 PM, Peter Rosin <peda@axentia.se> wrote:
> Hi!
>
> I'd like to add a devicetree for our Nattis to the kernel. The
> Nattis is a device for showing departures for public transportation
> (optionally including a text-to-speech module for the visually
> impaired).
>
> I'm a bit unsure if the tfa9879 sound codec binding is needed,
> but I suppose it belongs in trivial-devices?
>

There's a DT binding for this device now:

https://patchwork.ozlabs.org/patch/816157/

> Cheers,
> Peter
>

Best regards,
Javier
