From: jonathan.richardson@broadcom.com (Jonathan Richardson)
Date: Tue, 24 Jan 2017 16:19:20 -0800
Subject: [PATCH v2 1/3] dt-bindings: Document Broadcom iProc mailbox
 controller driver
In-Reply-To: <20170121204046.4trovvzfxdnfevns@rob-hp-laptop>
References: <1484789980-6812-1-git-send-email-jonathan.richardson@broadcom.com>
 <1484789980-6812-2-git-send-email-jonathan.richardson@broadcom.com>
 <20170121204046.4trovvzfxdnfevns@rob-hp-laptop>
Message-ID: <0da2563f-5b66-76a6-4210-d67a82f45098@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 17-01-21 12:40 PM, Rob Herring wrote:
> On Wed, Jan 18, 2017 at 05:39:38PM -0800, Jonathan Richardson wrote:
>
> Changelog?
I'll add one.
>
>> Reviewed-by: Jonathan Richardson <jonathan.richardson@broadcom.com>
>> Tested-by: Jonathan Richardson <jonathan.richardson@broadcom.com>
>> Reviewed-by: Vikram Prakash <vikram.prakash@broadcom.com>
>> Reviewed-by: Ray Jui <ray.jui@broadcom.com>
>> Reviewed-by: Shreesha Rajashekar <shreesha.rajashekar@broadcom.com>
>> Reviewed-by: Scott Branden <scott.branden@broadcom.com>
>> Signed-off-by: Jonathan Richardson <jonathan.richardson@broadcom.com>
>> ---
>>  .../devicetree/bindings/mailbox/brcm,iproc-mailbox.txt     | 14 ++++++++++++++
>>  1 file changed, 14 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/mailbox/brcm,iproc-mailbox.txt
>>
>> diff --git a/Documentation/devicetree/bindings/mailbox/brcm,iproc-mailbox.txt b/Documentation/devicetree/bindings/mailbox/brcm,iproc-mailbox.txt
>> new file mode 100644
>> index 0000000..f4c4f96
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/mailbox/brcm,iproc-mailbox.txt
>> @@ -0,0 +1,14 @@
>> +* Broadcom's iProc Mailbox Controller
>> +
>> +Required properties:
>> +- compatible: Must be "brcm,iproc-mailbox"
>> +- reg: Defines the base address of the mailbox controller.
>> +- #mbox-cells: Must be 1.
>> +
>> +Example:
>> +
>> +	mailbox: mailbox at 03024024 {
> Drop the leading 0.
I'll change in dtsi also.
>
>> +		compatible = "brcm,iproc-mailbox";
>> +		reg = <0x03024024 0x8>;
>> +		#mbox-cells = <1>;
>> +	};
>> -- 
>> 1.9.1
>>
