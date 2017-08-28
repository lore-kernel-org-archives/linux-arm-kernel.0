From: tklauser@distanz.ch (Tobias Klauser)
Date: Mon, 28 Aug 2017 10:36:11 +0200
Subject: [patch v6 3/3] Doccumentation: jtag: Add bindings for Aspeed SoC
 24xx and 25xx families JTAG master driver
In-Reply-To: <1503418256-5215-4-git-send-email-oleksandrs@mellanox.com>
References: <1503418256-5215-1-git-send-email-oleksandrs@mellanox.com>
 <1503418256-5215-4-git-send-email-oleksandrs@mellanox.com>
Message-ID: <20170828083610.GB1951@distanz.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2017-08-22 at 18:10:56 +0200, Oleksandr Shamray <oleksandrs@mellanox.com> wrote:
> It has been tested on Mellanox system with BMC equipped with
> Aspeed 2520 SoC for programming CPLD devices.
> 
> Signed-off-by: Oleksandr Shamray <oleksandrs@mellanox.com>
> Signed-off-by: Jiri Pirko <jiri@mellanox.com>
> Acked-by: Rob Herring <robh@kernel.org>
> ---
> v5->v6
> Comments pointed by Tobias Klauser <tklauser@distanz.ch>
> - Small nit: s/doccumentation/Documentation/

There's still one 'c' too many in 'Doccumentation' in the subject (in
case you're doing another respin of the series).
