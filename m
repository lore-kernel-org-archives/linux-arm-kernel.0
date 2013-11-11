From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 11 Nov 2013 07:54:45 -0200
Subject: imx-drm: possible circular locking dependency detected
In-Reply-To: <CAH9NwWdswcfwVOoCz3AmS8O7Adaun5tf3QJh5YE2iK96d3ajOg@mail.gmail.com>
References: <CAH9NwWdswcfwVOoCz3AmS8O7Adaun5tf3QJh5YE2iK96d3ajOg@mail.gmail.com>
Message-ID: <CAOMZO5A1i2jf1Mw-js=+ZF=rRL5JZFHD_d-KMhsqOuaZQx-9zw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Christian,

On Mon, Nov 11, 2013 at 7:25 AM, Christian Gmeiner
<christian.gmeiner@gmail.com> wrote:
> I am not sure if this problem is known but here is dmesg output. If a
> kernel config is needed I can
> send it

Please apply this patch:
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/commit/drivers/staging/imx-drm/imx-drm-core.c?id=c35d6a37bdcb1dde42dd65b00676696e2dd78f2f

Regards,

Fabio Estevam
