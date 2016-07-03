From: jic23@kernel.org (Jonathan Cameron)
Date: Sun, 3 Jul 2016 11:33:25 +0100
Subject: [PATCH v4 1/3] Documentation: DT: Add iproc-static-adc binding
In-Reply-To: <20160628210622.GA10297@rob-hp-laptop>
References: <1467099636-31855-1-git-send-email-raveendra.padasalagi@broadcom.com>
 <1467099636-31855-2-git-send-email-raveendra.padasalagi@broadcom.com>
 <20160628210622.GA10297@rob-hp-laptop>
Message-ID: <4c40177d-3501-5db9-b0e6-ba78354ab831@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28/06/16 22:06, Rob Herring wrote:
> On Tue, Jun 28, 2016 at 01:10:34PM +0530, Raveendra Padasalagi wrote:
>> The patch adds devicetree binding document for broadcom's
>> iproc-static-adc controller driver.
>>
>> Signed-off-by: Raveendra Padasalagi <raveendra.padasalagi@broadcom.com>
>> Reviewed-by: Ray Jui <ray.jui@broadcom.com>
>> Reviewed-by: Scott Branden <scott.branden@broadcom.com>
>> ---
>>  .../bindings/iio/adc/brcm,iproc-static-adc.txt     | 41 ++++++++++++++++++++++
>>  1 file changed, 41 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/iio/adc/brcm,iproc-static-adc.txt
> 
> Acked-by: Rob Herring <robh@kernel.org>
Thanks Rob for your review (sometimes I think I don't express often enough
how helpful device tree binding reviews are in general!)

Applied to the togreg branch of iio.git - initially pushed out as testing for
the autobuilders to ignore it completely ;)

Jonathan
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
