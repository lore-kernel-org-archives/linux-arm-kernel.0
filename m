From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Mon, 13 Aug 2018 14:14:25 +0300
Subject: [PATCH v3 2/2] arm64: dts: renesas: condor/v3hsk: add
 DU/LVDS/HDMI support
In-Reply-To: <20180614072426.vq42mmb3gsmv6z5k@verge.net.au>
References: <95d0db34-713d-8206-00c2-ee9a42aab823@cogentembedded.com>
 <c78f1228-afb0-54cf-5d9e-5c812b678de3@cogentembedded.com>
 <20180614072426.vq42mmb3gsmv6z5k@verge.net.au>
Message-ID: <5e60a349-3b80-f930-59cd-43b0f2e71238@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello!

On 06/14/2018 10:24 AM, Simon Horman wrote:

>> Define the Condor/V3HSK board dependent parts of the DU and  LVDS device
>> nodes. Also add the device nodes for Thine THC63LVD1024 LVDS decoder and
>> Analog Devices ADV7511W HDMI transmitter...
>>
>> Based on the original (and large) patch by Vladimir Barinov.
>>
>> Signed-off-by: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>>
>> ---
>> Changes in version 2:
>> - added the V3HSK DT update, reworded the description, renamed the patch;
>> - added a space between the HDMI node name and a brace.
>>
>>  arch/arm64/boot/dts/renesas/r8a77980-condor.dts |  106 +++++++++++++++++++++
>>  arch/arm64/boot/dts/renesas/r8a77980-v3hsk.dts  |  120 ++++++++++++++++++++++++
> 
> Laurent, could you review this?

   2 months have passed and no review so far...

MBR, Sergei
