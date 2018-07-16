From: ulrich.hecht@gmail.com (Ulrich Hecht)
Date: Mon, 16 Jul 2018 11:16:53 +0200
Subject: [PATCH v3 2/2] arm64: dts: renesas: condor/v3hsk: add
 DU/LVDS/HDMI support
In-Reply-To: <20180716075325.y7jtwyqxwerdmfy3@verge.net.au>
References: <95d0db34-713d-8206-00c2-ee9a42aab823@cogentembedded.com>
 <c78f1228-afb0-54cf-5d9e-5c812b678de3@cogentembedded.com>
 <20180614072426.vq42mmb3gsmv6z5k@verge.net.au>
 <20180716075325.y7jtwyqxwerdmfy3@verge.net.au>
Message-ID: <CAO3366wzXc+KY2uMVp5FGS9RyGyaFgktWS__kSTdu3AAWVxZKQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 16, 2018 at 9:53 AM, Simon Horman <horms@verge.net.au> wrote:
> On Thu, Jun 14, 2018 at 09:24:27AM +0200, Simon Horman wrote:
>> On Wed, Jun 13, 2018 at 11:12:40PM +0300, Sergei Shtylyov wrote:
>> > Define the Condor/V3HSK board dependent parts of the DU and  LVDS device
>> > nodes. Also add the device nodes for Thine THC63LVD1024 LVDS decoder and
>> > Analog Devices ADV7511W HDMI transmitter...
>> >
>> > Based on the original (and large) patch by Vladimir Barinov.
>> >
>> > Signed-off-by: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
>> > Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>> >
>> > ---
>> > Changes in version 2:
>> > - added the V3HSK DT update, reworded the description, renamed the patch;
>> > - added a space between the HDMI node name and a brace.
>> >
>> >  arch/arm64/boot/dts/renesas/r8a77980-condor.dts |  106 +++++++++++++++++++++
>> >  arch/arm64/boot/dts/renesas/r8a77980-v3hsk.dts  |  120 ++++++++++++++++++++++++
>>
>> Laurent, could you review this?
>
> Ping

For the Condor part:

Reviewed-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>

Unfortunately, I do not have documentation for the other board.

CU
Uli
