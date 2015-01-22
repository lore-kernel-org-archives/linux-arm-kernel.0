From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Thu, 22 Jan 2015 11:17:15 +0100
Subject: [GIT PULL] Renesas ARM Based SoC Drivers Updates for v3.20
In-Reply-To: <20150121224417.GD24851@quad.lixom.net>
References: <cover.1421371868.git.horms+renesas@verge.net.au>
 <20150121224417.GD24851@quad.lixom.net>
Message-ID: <CAMuHMdVrU1yNDAPGC-qL1EJ7BVe198KDg22Cd654Uzs9OKqiVg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof,

On Wed, Jan 21, 2015 at 11:44 PM, Olof Johansson <olof@lixom.net> wrote:
> On Fri, Jan 16, 2015 at 11:35:06AM +0900, Simon Horman wrote:
>> Please consider these Renesas ARM based SoC drivers updates for v3.20.
>>
>> The following changes since commit 97bf6af1f928216fd6c5a66e8a57bfa95a659672:
>>
>>   Linux 3.19-rc1 (2014-12-20 17:08:50 -0800)
>>
>> are available in the git repository at:
>>
>>   git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-drivers-for-v3.20

> Now, about this branch: There's not a single review by anyone on the
> drivers/bus pieces, nor on the binding. Please collect some, especially since
> simple-bus is used by so many.

I did receive review comments on v1, which I implemented in v2.
Simon applied v3.

Please note that this is not a driver for the common "simple-bus", but an
extension for buses that rely on clocks and/or PM domains.
The "simple-bus" base bindings were taken from ePAPR.

Anyway, I'm collecting some Ack's...

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
