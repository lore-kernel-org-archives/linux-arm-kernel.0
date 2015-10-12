From: broonie@kernel.org (Mark Brown)
Date: Mon, 12 Oct 2015 17:49:31 +0100
Subject: [PATCH 1/8] dt-bindings: pmic: Document Hi655x pmic driver
In-Reply-To: <56160E22.3010703@huawei.com>
References: <1443611111-3196-1-git-send-email-w.f@huawei.com>
 <1443611111-3196-2-git-send-email-w.f@huawei.com>
 <20150930173921.GJ15635@sirena.org.uk>
 <56160E22.3010703@huawei.com>
Message-ID: <20151012164931.GK4238@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 08, 2015 at 02:33:06PM +0800, wangfei wrote:
> On 2015/10/1 1:39, Mark Brown wrote:
> > On Wed, Sep 30, 2015 at 07:05:04PM +0800, Fei Wang wrote:

Please fix your mail client to word wrap within paragraphs at something
substantially less than 80 columns.  Doing this makes your messages much
easier to read and reply to.

> >> +                coul: coul at 1 {
> >> +                        compatible = "hisilicon,hi655x-coul";
> >> +                        interrupt-parent = <&pmic>;
> >> +                        interrupts = <24 0>, <25 0>, <26 0>, <27 0>;
> >> +                        interrupt-names = "cl_int_i", "cl_out_i", "cl_in_i", "vbat_int_i";
> >> +                        battery_product_index = <0>;

> > For example, the "battery_product_index" property here is undocumented.

> now on hikey, we only enable hi655x-regulator-pmic function, and
> regulator is child node of pmic.do i need to document regulator
> dt-binding in this file or create a new regulator dt-binding file?

Either is possible, though it is common to split the DT documentation
into per subsystem files for ease of reference and to avoid cross tree
merge issues.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151012/123109fb/attachment.sig>
