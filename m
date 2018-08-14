From: atull@kernel.org (Alan Tull)
Date: Tue, 14 Aug 2018 15:05:54 -0500
Subject: [RFC PATCH 1/2] ARM: dt: fpga: Added binding docs for Xilinx
 zynqmp FPGA manager
In-Reply-To: <20180814161917.GA26926@rob-hp-laptop>
References: <20180801100457.25614-1-nava.manne@xilinx.com>
 <20180814161917.GA26926@rob-hp-laptop>
Message-ID: <CANk1AXT6RkuFhWoFBy127j2Q=h9P-1S=0Mhyh9=PMJyC72sciQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 14, 2018 at 11:19 AM, Rob Herring <robh@kernel.org> wrote:

Hi Nava,

I didn't see this posting because it wasn't sent to my current email
address or to the linux-fpga mailing list.  People's email address
change at random times, so the easiest way to keep up is to always
check out the linux-next repo's master branch and look at the latest
MAINTAINERS file there.  Also there's a handy
./scripts/get_maintainer.pl script to make sure you include the right
people.

Alan

> On Wed, Aug 01, 2018 at 03:34:56PM +0530, Nava kishore Manne wrote:
>> New bindings document for zynqmp fpga manager.
>>
>> Signed-off-by: Nava kishore Manne <navam@xilinx.com>
>> ---
>>  .../devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga.txt   | 9 +++++++++
>>  1 file changed, 9 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga.txt
>>
>> diff --git a/Documentation/devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga.txt b/Documentation/devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga.txt
>> new file mode 100644
>> index 000000000000..0eac747747f5
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga.txt
>> @@ -0,0 +1,9 @@
>> +Xilinx Zynqmp FPGA Manager
>> +
>> +Required properties:
>> +- compatible:                should contain "xlnx,zynqmp-pcap-fpga"
>> +
>> +Example:
>> +     pcap: pcap at 00 {
>> +             compatible = "xlnx,zynqmp-pcap-fpga";
>
> How is this accessed? Via firmware interface? If so, need to define it
> is a child of the firmware node.
>
>> +     };
>> --
>> 2.18.0
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe devicetree" in
>> the body of a message to majordomo at vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
