From: robh@kernel.org (Rob Herring)
Date: Thu, 8 Jun 2017 17:21:50 -0500
Subject: [PATCHv3 3/4] dt-bindings: i2c: Add Altera I2C Controller
In-Reply-To: <1496447559-19782-4-git-send-email-thor.thayer@linux.intel.com>
References: <1496447559-19782-1-git-send-email-thor.thayer@linux.intel.com>
 <1496447559-19782-4-git-send-email-thor.thayer@linux.intel.com>
Message-ID: <20170608222150.xxlrzrfhhqqvuovl@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 02, 2017 at 06:52:38PM -0500, thor.thayer at linux.intel.com wrote:
> From: Thor Thayer <thor.thayer@linux.intel.com>
> 
> Add the documentation to support the Altera synthesizable
> logic I2C Controller in FPGA.
> 
> Signed-off-by: Thor Thayer <thor.thayer@linux.intel.com>
> ---
> v2  Change the subject to identify dt-bindings
>     Add synthesizable logic to description.
>     Change compatible string to "altr,softip-i2c"
>     Make description of clock phandle singular since 1 clock.
>     Remove altr, from fifo-size
>     Specify fifo-size is in bytes.
> v3  Add version to compatible string "altr,softip-i2c-v1.0"
>     Add for use in FPGA in description.
> ---
>  .../devicetree/bindings/i2c/i2c-altera.txt         | 39 ++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/i2c/i2c-altera.txt

Acked-by: Rob Herring <robh@kernel.org>
