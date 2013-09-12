From: galak@codeaurora.org (Kumar Gala)
Date: Thu, 12 Sep 2013 14:26:53 -0500
Subject: [PATCH] ARM: msm: Move msm devicetrees under a Qualcomm dir
In-Reply-To: <CAOesGMhSZzpyT5XyECByLnvef0E+92y+uaXByiG0Vpm9f05AxQ@mail.gmail.com>
References: <1379003839-16068-1-git-send-email-galak@codeaurora.org>
 <CAOesGMisWLwYKotGDFPW6PyHJs=_+fohTdC08SGjsv2FXaa7Fg@mail.gmail.com>
 <25E0B143-658E-4CCC-A88A-0AF70FFF33CE@codeaurora.org>
 <CAOesGMhfdvyJ_2AA2e8iO_2e=q7KgpyNbcriPKFw-RLormG6bA@mail.gmail.com>
 <3E38F48E-EE41-4564-84A1-36CF07B08811@codeaurora.org>
 <CAOesGMhN0jEx065cpf989P-JbuxPiOaPRsP4BD3VoW-n5ebP+w@mail.gmail.com>
 <9DD9D9A7-ED55-412F-A18D-599D1E365003@codeaurora.org>
 <523205E1.2040704@gmail.com>
 <CAOesGMhSZzpyT5XyECByLnvef0E+92y+uaXByiG0Vpm9f05AxQ@mail.gmail.com>
Message-ID: <584008C3-983C-4423-A76E-38DD67C2F1D9@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Sep 12, 2013, at 1:46 PM, Olof Johansson wrote:

> On Thu, Sep 12, 2013 at 11:20 AM, Rob Herring <robherring2@gmail.com> wrote:
> 
>> As Stephen W has pointed out previously, the dtb filename itself is or
>> may be an ABI and the bootloader may be hardcoded to a name. So we
>> should avoid future renames.
> 
> We still have the choice of producing the dtb files under
> arch/arm/boot/dts even if we move dts/dtsi files one level deeper, as
> long as we keep the filenames consistent. So we can do a move, just
> not a rename.


Looking at arch/arm/boot/dts/ we are all over the place, so what's the naming convention we are going forward with?

- k

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
