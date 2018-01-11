From: grant.likely@secretlab.ca (Grant Likely)
Date: Thu, 11 Jan 2018 19:56:01 +0000
Subject: [PATCH 2/3] dt-bindings: pinctrl: Add a ngpios-ranges property
In-Reply-To: <73078b7c-c3dd-0927-a82a-fb9369f5b576@codeaurora.org>
References: <20180110015848.11480-1-sboyd@codeaurora.org>
 <20180110015848.11480-3-sboyd@codeaurora.org>
 <CACRpkdaN6vmV4L4U76DvD5BN+j1RYCQakTysA+GGPdT8Chc-iw@mail.gmail.com>
 <CACxGe6vA652LCosMc+AsQ2Gb_mgiApx+Gxu9judXnO_p3AFcsw@mail.gmail.com>
 <73078b7c-c3dd-0927-a82a-fb9369f5b576@codeaurora.org>
Message-ID: <CACxGe6uJNEeDno4w84fCXQ103dKKysy+dyEvV2=QrL5YHNrEtQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 11, 2018 at 4:36 PM, Timur Tabi <timur@codeaurora.org> wrote:
> On 01/11/2018 10:33 AM, Grant Likely wrote:
>>
>> What level of access control is implemented here? Is there access
>> control for each GPIO individually, or is it done by banks of GPIOs?
>> Just asking to make sure I understand the problem domain.
>
>
> On our ACPI system, it's specific GPIOs.  Each GPIO is in its own 64k page,
> which is what allows us to block specific ones.

Okay, thanks.

g.

>
> --
> Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
> Technologies, Inc.  Qualcomm Technologies, Inc. is a member of the
> Code Aurora Forum, a Linux Foundation Collaborative Project.
