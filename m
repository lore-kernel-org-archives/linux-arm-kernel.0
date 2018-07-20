From: robh@kernel.org (Rob Herring)
Date: Fri, 20 Jul 2018 07:43:55 -0600
Subject: [PATCH v3 1/3] Input: edt-ft5x06 - Add support for regulator
In-Reply-To: <20180718182719.29663-2-mylene.josserand@bootlin.com>
References: <20180718182719.29663-1-mylene.josserand@bootlin.com>
 <20180718182719.29663-2-mylene.josserand@bootlin.com>
Message-ID: <20180720134355.GA24750@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 18, 2018 at 08:27:17PM +0200, Myl?ne Josserand wrote:
> Add the support of regulator to use it as VCC source.
> 
> Signed-off-by: Myl?ne Josserand <mylene.josserand@bootlin.com>
> ---
>  .../bindings/input/touchscreen/edt-ft5x06.txt      |  1 +

Please add acks when posting new versions.

>  drivers/input/touchscreen/edt-ft5x06.c             | 29 ++++++++++++++++++++++
>  2 files changed, 30 insertions(+)
