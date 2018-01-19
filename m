From: kieran.bingham@ideasonboard.com (Kieran Bingham)
Date: Fri, 19 Jan 2018 10:48:06 +0000
Subject: [PATCH 0/3] Add R8A77970/Eagle PFC support
In-Reply-To: <20171113075303.zmkmq6bt3lfuttwu@verge.net.au>
References: <20171110200218.747996672@cogentembedded.com>
 <20171113075303.zmkmq6bt3lfuttwu@verge.net.au>
Message-ID: <049b0a0a-b1c2-73e6-c471-ca8342bba6ab@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sergei,

On 13/11/17 07:53, Simon Horman wrote:
> On Fri, Nov 10, 2017 at 11:02:18PM +0300, Sergei Shtylyov wrote:
>> Hello!
>>
>> Here's the set of 3 patches against Simon Horman's 'renesas.git' repo's
>> 'renesas-devel-20171110-v4.14-rc8' tag.  We're adding the R8A77970 PFC node
>> and then describing the pins for SCIF0 and EtherAVB devices declared earlier.
>> These patches depend on the R8A77970 PFC suport in order to work properly.
>>
>> [1/3] arm64: dts: renesas: r8a77970: add PFC support
>> [2/3] arm64: dts: renesas: eagle: add SCIF0 pins
>> [3/3] arm64: dts: renesas: eagle: add EtherAVB pins
> 
> Hi Sergei,
> 
> I have marked these patches as deferred pending acceptance of the PFC
> driver. Please repost or otherwise ping me once that dependency has been
> accepted.

Has the dependency blocking this series been resolved yet ?

(I have patches for the Eagle-V3M which are blocked waiting for the PFC support)

--
Regards

Kieran


> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
