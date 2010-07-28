From: viresh.kumar@st.com (viresh kumar)
Date: Wed, 28 Jul 2010 13:45:06 +0530
Subject: JPEG hw decoder
In-Reply-To: <AANLkTin4r_NrQbzXoTWoJJRCUXX9mjfgtrJ9yTPLW5_W@mail.gmail.com>
References: <AANLkTin4r_NrQbzXoTWoJJRCUXX9mjfgtrJ9yTPLW5_W@mail.gmail.com>
Message-ID: <4C4FE70A.70101@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7/28/2010 10:42 AM, rd bairva wrote:
> Hi ,
>       My board has a hardware JPEG decoder. I want to write a driver
> for this in Linux kernel, But it seems there that no Framework exists
> in kernel. Can somebody provide me some pointers?

Hello Rbairva,

Which JPEG decoder are you working on??

I have Synopsys JPEG Decoder/Encoder on ST SPEAr platform
and i am currently working on its driver for LKML.

I already have a driver for it which is not aligned to LKML guidelines,
and so doing modifications there.
In my driver i have used char device framework and none other suits it well.

viresh.
