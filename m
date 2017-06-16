From: scott.branden@broadcom.com (Scott Branden)
Date: Fri, 16 Jun 2017 13:39:13 -0700
Subject: [PATCH RESEND 0/2] Add support for ARM CCN-502 interconnect
In-Reply-To: <1497595153-18908-1-git-send-email-scott.branden@broadcom.com>
References: <1497595153-18908-1-git-send-email-scott.branden@broadcom.com>
Message-ID: <d9491ea8-ae9a-b620-c5fd-44cd6c78d49c@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd,

Should this patchset go through the ARM maintainers?


On 17-06-15 11:39 PM, Scott Branden wrote:
> Add compatible string for ARM CCN-502 interconnect.
> CCN-502 interconnect is already compatible with the
> existing ARM CCN driver, which supports CCN-504.
>
> Velibor Markovski (2):
>    dt-bindings: arm-ccn: Add bindings info for CCN-502 compatible string
>    bus: arm-ccn: Enable stats for CCN-502 interconnect
>
>   Documentation/devicetree/bindings/arm/ccn.txt | 1 +
>   drivers/bus/arm-ccn.c                         | 1 +
>   2 files changed, 2 insertions(+)
>
