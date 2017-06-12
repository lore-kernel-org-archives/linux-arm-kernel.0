From: al.cooper@broadcom.com (Al Cooper)
Date: Mon, 12 Jun 2017 16:53:12 -0400
Subject: [PATCH 2/3] dt-bindings: Add Broadcom STB USB PHY binding document
In-Reply-To: <CAGh=XAAzbrNUopwsxQeXfRXi9gd=J4mdG-6UqTJ+-ikd=xqGig@mail.gmail.com>
References: <1496426512-10590-1-git-send-email-alcooperx@gmail.com>
 <1496426512-10590-3-git-send-email-alcooperx@gmail.com>
 <20170608221104.7nsinggo4vngbmus@rob-hp-laptop>
 <CAGh=XAAzbrNUopwsxQeXfRXi9gd=J4mdG-6UqTJ+-ikd=xqGig@mail.gmail.com>
Message-ID: <CAGh=XAAdMm6oGUjDNkiT_oK43gEK8_n+q1ynWo=e8+H7_g9wgw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 12, 2017 at 4:19 PM, Al Cooper <al.cooper@broadcom.com> wrote:
> On Thu, Jun 8, 2017 at 6:11 PM, Rob Herring <robh@kernel.org> wrote:
>>> +- brcm,device: String, PHY Device mode.
>>> +  Possible values are: off (Host), on (Device), dual (DRD)
>>> +  or typec-pd (Type-C PD control)
>>
>> I believe we have standard property for this though maybe not type C.
>>
>> off/on seem strange for meaning host/device as well.
>
> I'll change this to:
>
> mode: String, PHY Device mode.
> Possible values are: "host", "device", "drd" or "typec-pd"

I just found "dr_mode" in Documentation/devicetree/bindings/usb/generic.txt.
I'd like to change this to:

dr_mode: String, PHY Device mode.
Possible values are: "host", "device", "drd" or "typec-pd"

I used a standard property name ("dr_mode") and 2 of the standard
values ("host", "device") and added 2 new values "drd" and "typec_pd".

Thanks
Al
