From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 6 Dec 2017 09:41:43 -0200
Subject: [PATCH] ARM: dts: colibri/apalis: use correct compatible for RTC
In-Reply-To: <20171206102929.4755-1-stefan@agner.ch>
References: <20171206102929.4755-1-stefan@agner.ch>
Message-ID: <CAOMZO5CmKgKv2-qk0of9UKsn5QjtoYuY3SQ6xhueg7VmwNmieg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 6, 2017 at 8:29 AM, Stefan Agner <stefan@agner.ch> wrote:
> All Toradex Carrier Boards use a st,m41t0 compatible RTC. Compared
> to a st,m41t00 this RTC has also an oscillator fail bit which allows
> to detect when the RTC lost track of time.
>
> Cc: Sanchayan Maity <maitysanchayan@gmail.com>
> Cc: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> Signed-off-by: Stefan Agner <stefan@agner.ch>

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
