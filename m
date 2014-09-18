From: bjorn.andersson@sonymobile.com (Bjorn Andersson)
Date: Thu, 18 Sep 2014 10:51:40 -0700
Subject: [PATCH] ARM: dts: Add initial DTS file for Sony Xperia Z1 phone
In-Reply-To: <5418C471.9000807@sonymobile.com>
References: <5418C1D2.4000303@sonymobile.com>
 <27E278AA-EBC0-4368-B75C-DCB2DD906612@codeaurora.org>
 <5418C471.9000807@sonymobile.com>
Message-ID: <20140918175139.GK10179@sonymobile.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue 16 Sep 16:14 PDT 2014, Tim Bird wrote:

> 
> 
> On 09/16/2014 04:08 PM, Kumar Gala wrote:
> > 
> > On Sep 16, 2014, at 4:03 PM, Tim Bird <tim.bird@sonymobile.com> wrote:
[..]
> > 
> >> +	qcom,msm-id = <126 8 0>, <185 8 0>, <186 8 0>;
> > 
> > We don?t have qcom,msm-id upstream at this time.
> Do I just leave this out, then?

Both our tool to generate boot.img [1] and the Qualcomm equivalent require
these to be there.

Last time I tried to concatenate the dtb to zImage and using the Google
mkbootimg the bootloader refused to load the result. But please give it a test
and maybe we can postpone adding this definition. Otherwise we need to add a
definition - covering both the 8974 and 8974ab format.

[1] https://github.com/sonyxperiadev/mkqcdtbootimg

Regards,
Bjorn
