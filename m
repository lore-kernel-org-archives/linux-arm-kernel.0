From: eric.y.miao@gmail.com (Eric Miao)
Date: Wed, 28 Jul 2010 17:04:21 +0800
Subject: JPEG hw decoder
In-Reply-To: <4C4FE70A.70101@st.com>
References: <AANLkTin4r_NrQbzXoTWoJJRCUXX9mjfgtrJ9yTPLW5_W@mail.gmail.com>
	<4C4FE70A.70101@st.com>
Message-ID: <AANLkTikV9PAbKY+CQpcgXX01MOFx36G3LMg+nZ5pEy1q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 28, 2010 at 4:15 PM, viresh kumar <viresh.kumar@st.com> wrote:
> On 7/28/2010 10:42 AM, rd bairva wrote:
>> Hi ,
>> ? ? ? My board has a hardware JPEG decoder. I want to write a driver
>> for this in Linux kernel, But it seems there that no Framework exists
>> in kernel. Can somebody provide me some pointers?
>
> Hello Rbairva,
>
> Which JPEG decoder are you working on??
>
> I have Synopsys JPEG Decoder/Encoder on ST SPEAr platform
> and i am currently working on its driver for LKML.
>
> I already have a driver for it which is not aligned to LKML guidelines,
> and so doing modifications there.
> In my driver i have used char device framework and none other suits it well.
>

Normally the JPEG decoder/encoder comes with the video camera
module, which falls in v4l2 framework. Though not sure how well
the v4l2 API is gonna support this.

> viresh.
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
