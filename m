From: eric.y.miao@gmail.com (Eric Miao)
Date: Tue, 8 Jun 2010 17:13:40 +0800
Subject: [RFC] pxa: about ac97 for public use
In-Reply-To: <AANLkTinVD25v8HyOHDPWjpev7yp_tFqy_8S8Wa5njgYs@mail.gmail.com>
References: <AANLkTinVD25v8HyOHDPWjpev7yp_tFqy_8S8Wa5njgYs@mail.gmail.com>
Message-ID: <AANLkTik-JOU5UFRR44Iw74QH9iXyafJ7kiZ4QzChkDPR@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 8, 2010 at 4:58 PM, Wan ZongShun <mcuos.com@gmail.com> wrote:
> Hi Eric,
>
> Now, our pxa168 ac97 driver need the regs-ac97.h file support, but
> this file was located in mach-pxa/include.
> Should we move the public 'regs-ac97.h' to plat-pxa/ or create a new
> one in mach-mmp/include for pxa168 ac97 driver?

I'd rather to remove that file completely, to keep the register definitions
private to the relevant driver _only_.
