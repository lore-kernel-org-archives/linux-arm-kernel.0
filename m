From: robh@kernel.org (Rob Herring)
Date: Wed, 3 Jan 2018 13:48:23 -0600
Subject: [PATCH v2 1/2] Input: edt-ft5x06 - Add support for regulator
In-Reply-To: <20171228163336.28131-2-mylene.josserand@free-electrons.com>
References: <20171228163336.28131-1-mylene.josserand@free-electrons.com>
 <20171228163336.28131-2-mylene.josserand@free-electrons.com>
Message-ID: <20180103194823.xmdvf6xmgcosksgy@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 28, 2017 at 05:33:35PM +0100, Myl?ne Josserand wrote:
> Add the support of regulator to use it as VCC source.
> 
> Signed-off-by: Myl?ne Josserand <mylene.josserand@free-electrons.com>
> ---
>  .../bindings/input/touchscreen/edt-ft5x06.txt      |  1 +
>  drivers/input/touchscreen/edt-ft5x06.c             | 33 ++++++++++++++++++++++
>  2 files changed, 34 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>
