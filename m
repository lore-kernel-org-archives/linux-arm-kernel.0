From: olof@lixom.net (Olof Johansson)
Date: Mon, 10 Dec 2012 21:32:26 -0800
Subject: Errata on multiplatform kernels
In-Reply-To: <1355203223.16750.2.camel@gitbox>
References: <1355203223.16750.2.camel@gitbox>
Message-ID: <CAOesGMjJ=y4J70CaYYaEem0ni7Vb48KuEZKxaVYuCCCoMYwjPw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Dec 10, 2012 at 9:20 PM, Tony Prisk <linux@prisktech.co.nz> wrote:
> How are errata handled on multiplatform kernels?
>
> There don't appear to be any errata selected by default in any of the
> current multiplatform options, but presumably it will happen eventually.
>
> Does that mean the errata will be applied to all machines that boot with
> the errata selected, even if not required?

Yes. To date I believe most errata we have are just performance hits
on platforms that don't need it.

Other architectures have in some cases added runtime patching (out) of
workarounds that aren't needed on the current platform for the ones
that have significant performance impact. I'm guessing we'll end up
with something similar eventually but until then we'll try to just go
with the superset of needed errata.


-Olof
