From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 23 May 2018 11:44:01 +0200
Subject: [PATCH] gpio: zynq: Setup chip->base based on alias ID
In-Reply-To: <8b344d48-592d-8be8-bea0-e29b3e8469a1@xilinx.com>
References: <6ee982f8eb6e07f9ecbb0cc5093152f4a16b9c31.1523454899.git.michal.simek@xilinx.com>
 <CACRpkdbOa+AvhQT1RCWA_zQuTpp4qfNjZBFDOKLdaFqMGAe+cw@mail.gmail.com>
 <f9dd4f64-4026-f495-5810-32affb5b0944@xilinx.com>
 <CACRpkdaxwRc0zoDKogVGisXTPJ0EwLbOQjHzz1pSEjvWCsSCTQ@mail.gmail.com>
 <cc8d864a-e8e6-d30d-ae54-91819e5d0b8d@xilinx.com>
 <CACRpkdYgw+HaC5bUCZKiD7j+2ZLYbCTG+DdPdAEkRDq0xF5b3w@mail.gmail.com>
 <60652f48-2a98-414b-5cff-25890a6da37f@xilinx.com>
 <CACRpkdaNJzW+LO97oxavzYJwfkj0xu7wxTNRaGiaKm98ON5JMA@mail.gmail.com>
 <57e4bbdd-1e30-0352-f758-998b64a6b77f@xilinx.com>
 <8b344d48-592d-8be8-bea0-e29b3e8469a1@xilinx.com>
Message-ID: <CACRpkdb6pN=XYgWN7rPBGDwgpMjNLhgxVk_=QRTrHb=DZuU-xQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 15, 2018 at 3:26 PM, Michal Simek <michal.simek@xilinx.com> wrote:

> Have you done any decision about this patch?

Yeah I applied the patch. It's a bit of "choose the lesser evil" approach
but what can I do...

Yours,
Linus Walleij
