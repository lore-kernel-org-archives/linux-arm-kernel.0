From: al.cooper@broadcom.com (Al Cooper)
Date: Mon, 12 Jun 2017 16:19:07 -0400
Subject: [PATCH 2/3] dt-bindings: Add Broadcom STB USB PHY binding document
In-Reply-To: <20170608221104.7nsinggo4vngbmus@rob-hp-laptop>
References: <1496426512-10590-1-git-send-email-alcooperx@gmail.com>
 <1496426512-10590-3-git-send-email-alcooperx@gmail.com>
 <20170608221104.7nsinggo4vngbmus@rob-hp-laptop>
Message-ID: <CAGh=XAAzbrNUopwsxQeXfRXi9gd=J4mdG-6UqTJ+-ikd=xqGig@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 8, 2017 at 6:11 PM, Rob Herring <robh@kernel.org> wrote:
>> +- brcm,device: String, PHY Device mode.
>> +  Possible values are: off (Host), on (Device), dual (DRD)
>> +  or typec-pd (Type-C PD control)
>
> I believe we have standard property for this though maybe not type C.
>
> off/on seem strange for meaning host/device as well.

I'll change this to:

mode: String, PHY Device mode.
Possible values are: "host", "device", "drd" or "typec-pd"

Al
