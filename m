From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 12 Jun 2017 10:22:45 -0300
Subject: [PATCH 2/2] ARM: dts: imx6ul: Add imx6ul-tempmon
In-Reply-To: <1497268028.32422.15.camel@nxp.com>
References: <7055ce6095c0b7f026ac6f0dc37e43fc5c0b1793.1496939031.git.leonard.crestez@nxp.com>
 <b9b91617985607f24c4986bcad5199483805d6b7.1496939031.git.leonard.crestez@nxp.com>
 <CAOMZO5BP4fPyzDmSg+DFLRYh3QMf-8T0gqvnZn6mEMt-QqSgfw@mail.gmail.com>
 <1497005895.28352.88.camel@nxp.com>
 <20170609154638.3b64e6d0@karo-electronics.de>
 <1497022484.28352.105.camel@nxp.com>
 <20170612124029.1643469d@karo-electronics.de>
 <1497268028.32422.15.camel@nxp.com>
Message-ID: <CAOMZO5Dm8+1Ddh1QqkgNLbSrZPQgFL=EO6NcjusXA0Vi9mvXeg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 12, 2017 at 8:47 AM, Leonard Crestez
<leonard.crestez@nxp.com> wrote:

> However it seems that this might be accidental, it just happens that
> the OCOTP clock starts as enabled and is only disabled later in the

Most likely because U-Boot enabled the OCOTP clock as it reads the
speed grading fuse.
