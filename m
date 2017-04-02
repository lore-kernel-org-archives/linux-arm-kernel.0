From: festevam@gmail.com (Fabio Estevam)
Date: Sun, 2 Apr 2017 14:02:58 -0300
Subject: [PATCH 2/2] ARM: dts: imx7: add USDHC NAND clock to SDHC instances
In-Reply-To: <5c8339900fa1bd6215fb94d4386f7e06@agner.ch>
References: <20170330005029.6472-1-stefan@agner.ch>
 <20170330005029.6472-2-stefan@agner.ch>
 <20170401030312.GB24882@b29396-OptiPlex-7040>
 <5c8339900fa1bd6215fb94d4386f7e06@agner.ch>
Message-ID: <CAOMZO5CprxqnqRXMFJLBAgYAZGGnXNs3ZciyVz_mSLRnnSQQRQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Apr 1, 2017 at 1:15 AM, Stefan Agner <stefan@agner.ch> wrote:

> IMX7D_IPG_ROOT_CLK is currently not a valid clock in upstream... So we
> would have to add it to the clock driver first.
>
> I guess we could/should add it anyway at one point? But probably also as
> init on, just to make sure Linux does not disable it since it is
> currently used by several IPs implicitly.

Yes, I made a previous attempt do add  IMX7D_IPG_ROOT_CLK and it did
not work as I did not put it in the init_on clock list.

Will submit a new patch adding it to init_on, thanks.
